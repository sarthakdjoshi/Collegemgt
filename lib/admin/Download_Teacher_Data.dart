import 'package:flutter/material.dart';

class Download_Teacher_Data extends StatefulWidget {
  const Download_Teacher_Data({super.key});

  @override
  State<Download_Teacher_Data> createState() => _Download_Teacher_DataState();
}

class _Download_Teacher_DataState extends State<Download_Teacher_Data> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Teacher Data"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Center(
        child: Text("Hello"),
      ),
    );
  }
}
