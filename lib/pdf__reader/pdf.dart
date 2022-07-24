// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:internshiptask/pdf__reader/pdfapi.dart';
import 'package:internshiptask/pdf__reader/pdfview.dart';
import 'package:internshiptask/pdf__reader/pdfviewnetwork.dart';

import 'package:internshiptask/screens/homepage.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdf extends StatefulWidget {
  const pdf({Key? key}) : super(key: key);

  @override
  State<pdf> createState() => _pdfState();
}

class _pdfState extends State<pdf> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Links').snapshots();
  CollectionReference users = FirebaseFirestore.instance.collection('Links');
  TextEditingController name = TextEditingController();
  TextEditingController link = TextEditingController();
  String s = "";
  var l = {};

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "PDF",
        home: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFFFB30B00),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return (AlertDialog(
                      title: Text(
                        "ADD PDF",
                        style: TextStyle(color: Color(0xFFFB30B00)),
                      ),
                      actions: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 5),
                              child: TextField(
                                controller: name,
                                decoration: InputDecoration(
                                    hintText: "Health Insurance",
                                    labelText: "PDF NAME.",
                                    prefixIcon: Icon(Icons.file_copy),
                                    border: OutlineInputBorder()),
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 5),
                              child: TextField(
                                controller: link,
                                decoration: InputDecoration(
                                    hintText: "https://123cool.pdf",
                                    labelText: "PDF LINK.",
                                    prefixIcon: Icon(Icons.link),
                                    border: OutlineInputBorder()),
                                textInputAction: TextInputAction.done,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  RaisedButton(
                                    onPressed: () {
                                      users
                                          .add({
                                            'link': link.text,
                                            'name': name.text,
                                          })
                                          .then((value) => print("PDF ADDED"))
                                          .catchError((error) => print(
                                              "Failed to add pdf: $error"));
                                      link.clear();
                                      name.clear();
                                      Navigator.pop(context);
                                    },
                                    color: Color(0xFFFB30B00),
                                    child: Text(
                                      "ADD",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  RaisedButton(
                                    onPressed: () {
                                      link.clear();
                                      name.clear();
                                      Navigator.pop(context);
                                    },
                                    color: Color(0xFFFB30B00),
                                    child: Text(
                                      "CANCEL",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ));
                  });
            },
            child: Icon(Icons.add),
          ),
          bottomNavigationBar: Container(
            height: 50,
            color: Colors.grey[100],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                        onTap: () async {
                          final file = await PDFApi.pickFile();
                          if (file == null) {
                            return;
                          } else {
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return pdfview(path: file);
                              }),
                            );
                          }
                        },
                        child: Icon(Icons.folder)),
                    Text("Browse")
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return homepage();
                          }));
                        },
                        child: Icon(Icons.home)),
                    Text("Home")
                  ],
                )
              ],
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 25),
                          child: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              // ignore: prefer_const_constructors
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return homepage();
                                      },
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                "PDF READER",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Color(0xFFFB30B00),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(100),
                        )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Expanded(
                          child: StreamBuilder(
                              stream: _usersStream,
                              builder:
                                  (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Something went wrong..'));
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(child: Text("Loading...."));
                                }
                                if ((snapshot.data?.docs.length == 0)) {
                                  return Center(
                                    child: (Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: 150,
                                                width: 150,
                                                child: Image.asset(
                                                    "assets/nodata.png"),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 50.0),
                                                child: Text(
                                                    "No PDFs are added, try adding some pdfs by "),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 50.0),
                                                child: Text(
                                                    "pressing that add button."),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 50.0),
                                                child: Text(
                                                    "Note:- Make sure to add correct .pdf links !"),
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    )),
                                  );
                                }
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      itemCount: snapshot.data?.docs.length,
                                      itemBuilder: (context, index) {
                                        Map<String, dynamic>? doc =
                                            snapshot.data?.docs[index].data()
                                                as Map<String, dynamic>?;

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30.0, vertical: 10.0),
                                          child: (Container(
                                            height: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  child: Image.asset(
                                                      "assets/pdfic.png"),
                                                ),
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Text(
                                                        doc!['name'],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17),
                                                      ),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        " .pdf",
                                                        style: TextStyle(
                                                            color: Colors.grey),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return pdfviewnetwork(
                                                            url: doc['link']);
                                                      }));
                                                    },
                                                    child: Container(
                                                        child: Icon(Icons
                                                            .open_in_new))),
                                                Container(
                                                  child: Icon(Icons.download),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    snapshot.data?.docs[index]
                                                        .reference
                                                        .delete();
                                                  },
                                                  child: Container(
                                                    child: Icon(Icons.delete),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                        );
                                      });
                                }

                                return Text("k");
                              }),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
