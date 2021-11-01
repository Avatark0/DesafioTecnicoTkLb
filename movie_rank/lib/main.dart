import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Ranker',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tokenlab Movie Ranker'),
        ),
        body: const Center(
          child: Text('Many movies, great rank'),
        ),
      ),
    );
  }
}

