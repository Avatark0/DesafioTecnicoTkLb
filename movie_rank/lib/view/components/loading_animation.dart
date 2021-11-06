import 'package:flutter/material.dart';

class LoadingAnimation extends StatelessWidget{
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const Center(
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
    );
  }

}