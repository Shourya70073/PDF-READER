import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:internshiptask/pdf__reader/pdf.dart';

class pdfloading extends StatefulWidget {
  const pdfloading({Key? key}) : super(key: key);

  @override
  State<pdfloading> createState() => _pdfloadingState();
}

class _pdfloadingState extends State<pdfloading> with SingleTickerProviderStateMixin {
   late AnimationController c;
  @override
  void initState() {
    // TODO: implement initState
    timer();
    super.initState();
    c = AnimationController(
        duration: Duration(seconds: 1),
        lowerBound: 20,
        upperBound: 60,
        vsync: this);

    c.forward();
    c.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        c.reverse(from: 100);
      } else if (status == AnimationStatus.dismissed) {
        c.forward();
      }
    });
    c.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    c.dispose();
  }

  void timer() {
    Timer(
      Duration(seconds: 3),
      (() {
        // ignore: prefer_const_constructors
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return pdf();
          }),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return(Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Hero(
          tag: "pdf",
          child: Container(
            height: c.value,
            width: c.value,
            child: Image.asset("assets/pdfic.png")),
        ),
      ),
    ));
  }
}