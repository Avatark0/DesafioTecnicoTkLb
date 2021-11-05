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
      theme: ThemeData(scaffoldBackgroundColor: Colors.purple.shade100),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade300,
          elevation: 0.5,
          title: const Text('Tokenlab Mobile - Desafio Técnico'),
        ),
        body: 
        Center(
          child: FutureBuilder<List<Movie>>(
            future: futureMovieList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _listView(snapshot);
              } else if (snapshot.hasError) {
                return _containerErrorMessage(snapshot);
              }
              // By default, show a loading spinner.
              return _containerLoadingAnimation();
            }
          ),
        ),
      ),

      debugShowCheckedModeBanner: false,
    );
  }

//Implementation of the horizontal list, cache controll
  ListView _listView(AsyncSnapshot snapshot){
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      cacheExtent: 400.0,
      padding: const EdgeInsets.all(18.0),
      itemCount: snapshot.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return _containerCachedImage(snapshot, index);
      }
    );
  }

  Widget _containerCachedImage(AsyncSnapshot snapshot, int index){
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
      color: Colors.purple.shade200,
      width: 400,
      //padding: const EdgeInsets.all(20.0),
      margin: const EdgeInsets.all(18.0),
    );
  }

  CachedNetworkImage _cachedImage(AsyncSnapshot snapshot, int index){
    return CachedNetworkImage(
      placeholder: (context, url) => _containerLoadingAnimation(),
      errorWidget: (context,url,error) => _containerImageNotLoaded(snapshot, index),
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
      enableFeedback: true,
      onTap: (){
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => SecondRoute()),
      // );
      }
    );
  }

  //Container para mensagem de erro na conexão com o BD. Texto de template para uma imagem explicativa.
  Widget _containerErrorMessage(AsyncSnapshot snapshot){
    return Container(
      child: Stack(children: <Widget>[
          Positioned.fill(
            child: Text(
              '\n\n\n\n\n\n${snapshot.error}\n\nCheck your internet conection, or try again later.',
              textAlign: TextAlign.center,
            ),
          )
      ]),
    );
  }

  Widget _containerImageNotLoaded(AsyncSnapshot snapshot, int index){
    return Container(
      child: Stack(children: <Widget>[
          Positioned.fill(
            child: Text(
              '\n\n\n\n\n\n'+snapshot.data![index].title,
              textAlign: TextAlign.center,
            ),
          )
      ]),
    );
  }

  Widget _containerLoadingAnimation(){
    return Container(
      //margin: const EdgeInsets.only(top: 100.0),
      child: const Center(
        child: 
          SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              strokeWidth: 10,
              valueColor: 
              AlwaysStoppedAnimation(Colors.purple),
            ),
          ),
      ),
    );
  }


}