import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:internshiptask/pdf__reader/pdf.dart';
import 'package:internshiptask/pdf__reader/pdf_loading.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  PageController c = PageController();
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HOMEPAGE",
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: PageView(controller: c, children: [
            
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Hero(
                            tag: "pdf",
                            child: Container(
                                height: 150,
                                width: 200,
                                child: Image.asset("assets/pdfic.png")),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "Developed by Adobe Inc. from 1998 to 2008, PDF was standardized as IOS 32000 in 2008. Before that, companies who want to make, sell, use, distribute, and develop PDF-compliant implementations need to pay patent royalty to Adobe as PDF was a proprietary format.",
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        
                        ],
                      ),
                      decoration: BoxDecoration(color: Colors.grey[900]),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Center(
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return pdfloading();
                            }));
                          },
                          color: Colors.grey[900],
                          child: Text(
                            "PDF READER",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}
