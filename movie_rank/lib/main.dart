import 'package:flutter/material.dart';
import 'view/movie_list.dart';
import 'view/movie_details.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MovieList(),
        '/movie': (context) => const MovieDetails(movieId: '',),
      },
    )
  );
}
