import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Ranker',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tokenlab Movie Ranker'),
        ),
        body: const Center(
          child: MovieList(),
        ),
      ),

      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      debugShowCheckedModeBanner: false,
    );
  }
}

class MovieList extends StatefulWidget {
  const MovieList({ Key? key }) : super(key: key);
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final _moviesList = <String>['01 aaaa','02 bbbb','03 cccc','04 dddd','05 eeee','06 ffff','07','08','09','10','11','12','13','14','15','16','17','18','19','20'];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Name Generator'),
      ),
      body: _buildMoviesList(),
    );
  }

  Widget _buildMoviesList(){
    return ListView.builder(
      padding: const EdgeInsets.all(18.0),
      itemCount: _moviesList.length,
      itemBuilder: (context, index) {
        final _movieElement =_moviesList[index];
        return _buildRow(_movieElement);
      }
    );
  }

  //Representa cada linha da lista montada. Precisa receber imagem e titulo. Mudar formato de movieInfo (para colection?)
  Widget _buildRow(String movieInfo){
    return ListTile(
      title: Text(
        movieInfo,
        style: _biggerFont,
      ),
    );
  }
}
