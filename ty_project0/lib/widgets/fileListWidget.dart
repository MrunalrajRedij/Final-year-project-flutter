import 'dart:isolate';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:share/share.dart';
import 'package:ty_project0/firebaseApi.dart';
import 'package:ty_project0/models/fileList.dart';

class FileListWidget extends StatefulWidget {
  FileList fileList;
  FileListWidget({required this.fileList});

  @override
  _FileListWidgetState createState() => _FileListWidgetState();
}

class _FileListWidgetState extends State<FileListWidget> {
  ReceivePort _receivePort = ReceivePort();
  double progress = 0;

  static downloadingCallback(id, status, progress) {
    SendPort? sendPort = IsolateNameServer.lookupPortByName('downloading');
    sendPort!.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, 'downloading');
    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });
    });
    FlutterDownloader.registerCallback(downloadingCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
      decoration: BoxDecoration(
          color: Color(0xffBCD2EE),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent,
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(5, 5),
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.fileList.fileName,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            widget.fileList.description,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: () async {
                    FirebaseApi.downloadFile(
                        widget.fileList.fileName, widget.fileList.downloadUrl);
                  },
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xffBCD2EE),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 0.8,
                            offset: Offset(1, 1),
                          )
                        ],
                      ),
                      child: Icon(Icons.download)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                    onTap: () {
                      Share.share(widget.fileList.downloadUrl);
                    },
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0xffBCD2EE),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 0.8,
                              offset: Offset(1, 1),
                            )
                          ],
                        ),
                        child: Icon(Icons.share))),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
