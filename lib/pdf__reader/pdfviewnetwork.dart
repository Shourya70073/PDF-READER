import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class pdfviewnetwork extends StatefulWidget {
  final url;
  const pdfviewnetwork({@required this.url, Key? key}) : super(key: key);

  @override
  State<pdfviewnetwork> createState() => _pdfviewnetworkState();
}

class _pdfviewnetworkState extends State<pdfviewnetwork> {
  late PdfViewerController c;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c = PdfViewerController();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFB30B00),
        actions: [
          GestureDetector(
            onTap: (() {
              c.zoomLevel += 1.25;
            }),
            child: const Icon(
              Icons.zoom_in,
              size: 30,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          GestureDetector(
            onTap: () {
              c.zoomLevel += -0.5;
            },
            child: Icon(
              Icons.zoom_out,
              size: 30,
            ),
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.url,
        controller: c,
      ),
    ));
  }
}
