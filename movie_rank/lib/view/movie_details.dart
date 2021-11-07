import 'package:flutter/material.dart';
import 'package:movie_rank/values/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '/model/movie.dart';
import '/controller/fetch_data.dart';
import 'components/error_message.dart';
import 'components/loading_animation.dart';

//Secondary view for the API
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
          title: Text(
            'Tokenlab - TMDB',
            style: TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: FutureBuilder<Movie>(
            future: futureMovie,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _details(snapshot);
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

  Widget _details(AsyncSnapshot<Movie> snapshot) => Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    color: Colors.purple.shade300,
    child: Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  height: 150,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(snapshot.data!.posterUrl),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                  ),
                  height: 150,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 200,
                        child: Text(
                          snapshot.data!.title,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: 200,
                        child: Text(
                          snapshot.data!.tagLine as String,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 16),
                        ),
                      )
                    ],),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Container(
            height: 324,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Release date: '+snapshot.data!.releaseDate,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 25),
                Text(
                  snapshot.data!.overview as String,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton(
              child: const Text('Return'),
              onPressed: (){
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                onPrimary: Colors.black,
                textStyle: const TextStyle(
                ),
              ),
            ),
          ),
        ],
      ),
    ), 
  );

}
