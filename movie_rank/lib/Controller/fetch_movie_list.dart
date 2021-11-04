import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_rank/Model/Movie.dart';

Future<List<Movie>> fetchMovieList(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var data = jsonDecode(response.body);
    List<Movie> movieList = [];
    for(var movie in data){
      Movie newMovie = Movie.fromJson(movie);
      movieList.add(newMovie);
    }
    return movieList;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movie list.');
  }
}