import 'dart:async';

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

class LoadingAnimationWithTimeout extends StatefulWidget {
  const LoadingAnimationWithTimeout({Key? key}) : super(key: key);
  
  @override
  _LoadingAnimationWithTimeoutState createState() => _LoadingAnimationWithTimeoutState();
}

class _LoadingAnimationWithTimeoutState extends State<LoadingAnimationWithTimeout> {
  Duration duration = const Duration();
  Timer? timer;
  bool countDown =true;

  @override
  void initState() {
    super.initState();
    
  }

@override
  Widget build(BuildContext context){
    if(countDown){
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
    } else{
      return Container();
    }
  }

  void startTimer(){
    timer = Timer.periodic(const Duration(seconds: 2),(_) => addTime());
  }

  void addTime(){
    final addSeconds = countDown ? -1 : 1;
    setState((){
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0){
        timer?.cancel();
      }else{
        duration = Duration(seconds: seconds);
      }
    });
  }
}