import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart' as excel_lib;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
class DownloadStudentData extends StatelessWidget {
  const DownloadStudentData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Download Student Data"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                exportToExcel(context);
              },
              child: const Text("Download Excel File For Android"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> exportToExcel(BuildContext context) async {
   bool permissionGranted = await requestPermission(Permission.storage);
      if (!permissionGranted) {
        return;
      }
      await _exportToExcelMobile(context);
    }
  }

  Future<void> _exportToExcelMobile(BuildContext context) async {
    // Fetch data from Firestore
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Students').get();

    // Create Excel file using excel_lib.createExcel()
    var excel = excel_lib.Excel.createExcel();
    var sheet = excel['Sheet1'];

    // Add headers
    sheet.appendRow(['Name', 'City']);

    // Add data from Firestore
    for (var doc in querySnapshot.docs) {
      sheet.appendRow([doc['name'], doc['city'].toString()]);
    }

    // Get the external storage directory
    Directory? directory = await getExternalStorageDirectory();
    if (directory == null) {
      // Handle if external storage directory is null (e.g., on iOS devices)
      return;
    }

    // Save the Excel file
    String excelFileName = 'students.xlsx';
    String excelFilePath = '${directory.path}/$excelFileName';
    var excelBytes = excel.encode(); // Get the binary data of the excel file
    if (excelBytes == null) {
      // Handle encoding error
      return;
    }

    File(excelFilePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excelBytes);

    // Inform the user that export is complete
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Export Complete'),
        content: Text('Excel file saved to: $excelFilePath'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(_),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  Future<bool> requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      PermissionStatus status = await permission.request();
      return status == PermissionStatus.granted;
    }
  }
