import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PdfView extends StatefulWidget{
  final String url;
  final String name;

  PdfView(this.url,this.name);

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  PDFDocument ? document;
  void abc() async{
      document= await PDFDocument.fromURL(widget.url);
      setState(() {

      });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    abc();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body:document!=null? PDFViewer(
        document: document!,
      ):Center(child: CircularProgressIndicator(),),
    );
  }
}