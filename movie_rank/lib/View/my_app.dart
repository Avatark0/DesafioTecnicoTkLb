import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';

import 'package:movie_rank/Model/Movie.dart';
import 'package:movie_rank/Controller/fetch_movie_list.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  late Future<List<Movie>> futureMovieList;
  final String url = 'https://desafio-mobile.nyc3.digitaloceanspaces.com/movies';

  @override
  void initState() {
    super.initState();
    futureMovieList = fetchMovieList(url);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tokenlab Desafio Tecnico',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0.5,
          title: const Text('Tokenlab Mobile - Desafio Técnico'),
        ),
        body: 
        Center(
          child: FutureBuilder<List<Movie>>(
            future: futureMovieList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //return _moviesListView(snapshot);
                return _listView(snapshot);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }
          ),
        ),
      ),

      debugShowCheckedModeBanner: false,
    );
  }

  ListView _listView(AsyncSnapshot snapshot){
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      cacheExtent: 400.0,
      padding: const EdgeInsets.all(18.0),
      itemCount: snapshot.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return _container(snapshot, index);
      }
    );
  }

  Widget _container(AsyncSnapshot snapshot, int index){
    return Container(
      child: 
        Stack(children: <Widget>[
          Positioned.fill(
            child: _cachedImage(snapshot, index),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child:_inkWell(snapshot, index),
            )
          )
        ]),
      color: Colors.purple,
      width: 400,
      //padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(10.0),
    );
  }

  CachedNetworkImage _cachedImage(AsyncSnapshot snapshot, int index){
    return CachedNetworkImage(
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context,url,error) => Text(
        snapshot.data![index].title),
      imageUrl: snapshot.data![index].poster_url,
      fadeInCurve: Curves.bounceIn,
      fadeInDuration: const Duration(milliseconds: 1000),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: CachedNetworkImageProvider(snapshot.data![index].poster_url),
              fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _inkWell(AsyncSnapshot snapshot, int index){
    return InkWell(
      //child: _container(snapshot, index),
      enableFeedback: true,
      onTap: (){
      //  Navigator.push(context, route) {
      //         //sideLength == 50 ? sideLength = 100 : sideLength = 50;
      //   });
      }
    );
  }


}