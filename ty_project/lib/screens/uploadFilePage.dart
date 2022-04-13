import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:ty_project/firebaseApi.dart';

class UploadFilePage extends StatefulWidget {
  @override
  _UploadFilePageState createState() => _UploadFilePageState();
}

class _UploadFilePageState extends State<UploadFilePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var file;
  String? description;
  UploadTask? task;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? "File name: "+basename(file!.path) : "File name: {No file Selected}";
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Image(
                    image: AssetImage('assets/images/education.png'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffBCD2EE),
                          spreadRadius: 10,
                          blurRadius: 7,
                          offset: Offset(3, 5),
                        )
                      ]),
                  child: Column(
                    children: [
                      SizedBox(height: 10.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffe5e4e2),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(fileName),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                          child: Text("Select File"),
                          onPressed: () {
                            selectFile();
                          }),
                      SizedBox(height: 10.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffe5e4e2),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          onChanged: (input) {
                            description = input;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                            hintText: "Add description here",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: () {
                          uploadFile();
                        },
                        child: Text("Upload File"),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;
    setState(() {
      file = File(path!);
    });
  }

  Future uploadFile() async {
    if (file == null) return;

    showDialog(
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Uploading..."),
          actions: [
            Center(child: CircularProgressIndicator()),
            SizedBox(height: 10.0)
          ],
        );
      },
    );

    task =
        await FirebaseApi.uploadFile(description ?? "{No description}", file);

    final uploadingCompletedSnackBar = SnackBar(content: Text("File successfully uploaded!"));
    ScaffoldMessenger.of(this.context).showSnackBar(uploadingCompletedSnackBar);

    Navigator.pop(this.context);
  }
}
