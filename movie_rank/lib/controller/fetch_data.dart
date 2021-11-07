import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:movie_rank/model/movie.dart';
import '/controller/save_data.dart';

//Fetch the data. Try to fetch from the internet, if unable, try to fetch from local storage.
class FetchData{
  static const int timeoutTime = 3;

  Future<List<Movie>> fetchMovieList(String url) async {
    const String movieListIdPath = 'MovieListData';
    var data;
    try{
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: timeoutTime));

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        data = jsonDecode(response.body);
        
        //Save downloaded data to cache.
        SaveData().writeData(jsonEncode(data), movieListIdPath);
      } else {
        //If it is unable to get the data from the web, try to read it from cache.
        String recoveredData = await SaveData().readData(movieListIdPath);
        data = jsonDecode(recoveredData);
      }

      //If it got the data, convert it to the apropriate format.
      if(data != null){
        List<Movie> movieList = [];
        for(var movie in data){
          Movie newMovie = Movie.fromJson(movie);
          movieList.add(newMovie);
        }
        return movieList;
      }
    }
    //In case there is no conection to the internet, and a timeout exception is thrown.
    on TimeoutException{
      String recoveredData = await SaveData().readData(movieListIdPath);
      data = jsonDecode(recoveredData);
      if(data != null){
        List<Movie> movieList = [];
        for(var movie in data){
          Movie newMovie = Movie.fromJson(movie);
          movieList.add(newMovie);
          //print(movie);
        }
        return movieList;
      }
    }
    //If no data could be fetch, log details on console and display an error message.
    on Error catch (e) {
      print('fetch_data - General Error: $e');
    }
    throw Exception('Failed to load movie list.');
  }

  Future<Movie> fetchMovieDetails(String url, String id) async {
    final String movieIdPath = 'MovieList$id';
    var data;
    try{
    final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: timeoutTime));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      data = jsonDecode(response.body);

      //Save downloaded data to cache
      SaveData().writeData(jsonEncode(data), movieIdPath);
      } else {
        //If there it is unable to get the data from the web, try to read it from cache.
          data = jsonDecode(await SaveData().readData(movieIdPath));
      }
      //If it got the data, convert it to the apropriate format.
      Movie movie = Movie.fromJson(data);
      return movie;
    }
    //In case there is no conection to the internet, and a timeout exception is thrown.
    on TimeoutException{
      String recoveredData = await SaveData().readData(movieIdPath);
      data = jsonDecode(recoveredData);
      Movie movie = Movie.fromJson(data);
      return movie;
    } 
    //If no data could be fetch, log details on console and display an error message.
    on Error catch (e) {
      print('fetch_data - General Error: $e');
    }
    throw Exception('Failed to load movie details.');
  }
}