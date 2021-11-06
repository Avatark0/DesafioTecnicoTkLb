import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget{
  const ErrorMessage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context){
    return Stack(children: const <Widget>[
        Positioned.fill(
          child: Text(
            '\n\n\n\n\n\nAn error occurred!\n\nCheck your internet conection, or try again later.',
            textAlign: TextAlign.center,
          ),
        )
    ]);
  }

}