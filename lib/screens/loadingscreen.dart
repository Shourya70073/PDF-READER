import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    timer();
  }

  void timer() {
    Timer(
      Duration(seconds: 3),
      (() {
        // ignore: prefer_const_constructors
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return homepage();
          }),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Container(
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30.0,
                fontFamily: 'Agne',
              ),
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText('Loading...'),
                ],
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
          ),
        )));
  }
}
