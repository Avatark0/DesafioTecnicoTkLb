import 'package:flutter/material.dart';
import 'package:movie_rank/values/constants.dart';

import '/model/movie.dart';
import '/controller/fetch_data.dart';
import 'components/error_message.dart';
import 'components/loading_animation.dart';

class MovieDetails extends StatefulWidget {
  final String movieId;

  const MovieDetails({Key? key, required this.movieId}) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

  class _MovieDetailsState extends State<MovieDetails>{
  late Future<Movie> futureMovie;
  late String url;

  @override
  void initState() {
    super.initState();
    url = UrlPath.mainUrl +'/'+ widget.movieId;
    futureMovie = FetchData().fetchMovieDetails(url, widget.movieId);
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tokenlab TMDB ',
      theme: ThemeData(scaffoldBackgroundColor: Colors.purple.shade100),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade300,
          elevation: 0.5,
          title: const Text('Tokenlab - TMDB 2'),
        ),
        body: Center(
          child: FutureBuilder<Movie>(
            future: futureMovie,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _listView(snapshot);
              } else if (snapshot.hasError) {
                print('movie_details: error reading snapshot data');
                return const ErrorMessage();
              }
              // By default, show a loading spinner.
              return const LoadingAnimation();
            }
          ),
        ),
      ),
    );
  }

  Widget _listView(AsyncSnapshot<Movie> snapshot) {
    return ListView.builder(
      // scrollDirection: Axis.horizontal,
      // cacheExtent: 400.0,
      // padding: const EdgeInsets.all(18.0),
       itemCount: 2,
       itemBuilder: (BuildContext context, int index) {
         return Text(snapshot.data!.title);
      // return _containerCachedImage(snapshot, index);
       }
    );
  }
  // Widget _containerImageNotLoaded(AsyncSnapshot snapshot, int index){
  //   return Stack(children: <Widget>[
  //       Positioned.fill(
  //         child: Text(
  //           '\n\n\n\n\n\n'+snapshot.data![index].title,
  //           textAlign: TextAlign.center,
  //         ),
  //       )
  //   ]);
  // }

  // child: ElevatedButton(
  //   onPressed: (){
  //     Navigator.pop(context);
  //   },
  //   child: const Text('Go back!'),
  // ),

}
