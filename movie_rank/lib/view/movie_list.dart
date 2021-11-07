import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_rank/values/constants.dart';

import '/model/movie.dart';
import '/controller/fetch_data.dart';
import '/controller/transition_animation.dart';
import 'movie_details.dart';
import 'components/error_message.dart';
import 'components/loading_animation.dart';

//Main view for the API
class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);
  
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList>{
  late Future<List<Movie>> futureMovieList;

  @override
  void initState() {
    super.initState();
    futureMovieList = FetchData().fetchMovieList(UrlPath.mainUrl);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tokenlab Desafio Tecnico',
      theme: ThemeData(scaffoldBackgroundColor: Colors.purple.shade100),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade300,
          elevation: 0.5,
          title: Text(
            'Tokenlab - TMDB',
            style: TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
            ),
          ),
        ),
        body: 
        Center(
          //Call to fetch the data.
          child: FutureBuilder<List<Movie>>(
            future: futureMovieList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _listView(snapshot);
              } else if (snapshot.hasError) {
                  print('movie_list: error reading snapshot data');
                return const ErrorMessage();
              }
              //While fetching, show a loading spinner.
              return const LoadingAnimation();
            }
          ),
        ),
      ),
    );
  }

  //Display the movie list and controls the cache for list items.
  ListView _listView(AsyncSnapshot snapshot){
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      cacheExtent: 1000.0,
      padding: const EdgeInsets.all(18.0),
      itemCount: snapshot.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: const EdgeInsets.all(18.0),
          width: 400,
          decoration: BoxDecoration(
            color: Colors.purple.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: 
            Stack(children: <Widget>[
              Positioned.fill(
                child: CachedNetworkImage(
                  placeholder: (context, url) => const LoadingAnimation(),
                  errorWidget: (context,url,error) => _containerImageNotLoaded(snapshot, index),
                  imageUrl: snapshot.data![index].posterUrl,
                  fadeInCurve: Curves.bounceIn,
                  fadeInDuration: const Duration(milliseconds: 1000),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(snapshot.data![index].posterUrl),
                          fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child:_inkWell(snapshot, index),
                )
              )
            ]),
        );
      }
    );
  }

  //Controls the call to the second view.
  Widget _inkWell(AsyncSnapshot snapshot, int index){
    String movieId = snapshot.data![index].id.toString();
    return InkWell(
      enableFeedback: true,
      onTap: (){
        Navigator.push(
          context,
          NoAnimationMaterialPageRoute(builder: (context) => MovieDetails(movieId: movieId)),
        );
        setState(() {});
      },
    );
  }

  //Displays the movie title when the image could not be loaded.
  Widget _containerImageNotLoaded(AsyncSnapshot snapshot, int index){
    return Stack(children: <Widget>[
      Positioned.fill(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 30),
            SizedBox(
              width: 200,
              child: Text(
                snapshot.data![index].title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ]
        ),
      ),
    ]);
  }

}