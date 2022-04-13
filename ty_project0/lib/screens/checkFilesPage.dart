import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ty_project0/models/fileList.dart';
import 'package:ty_project0/widgets/fileListWidget.dart';

class CheckFilesPage extends StatefulWidget {

  @override
  _CheckFilesPageState createState() => _CheckFilesPageState();
}

class _CheckFilesPageState extends State<CheckFilesPage> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("");
  var stream;

  @override
  void initState() {
    super.initState();
    stream = FirebaseFirestore.instance.collection("files").snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: cusSearchBar,
        actions: [
          IconButton(
            icon: cusIcon,
            onPressed: () {
              setState(
                    () {
                  if (this.cusIcon.icon == Icons.search) {
                    this.cusIcon = Icon(Icons.cancel);
                    this.cusSearchBar = TextField(
                      cursorColor: Colors.white60,
                      textInputAction: TextInputAction.go,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.search,
                          color: Colors.white60,
                        ),
                        hintText: "Search here...",
                        hintStyle: TextStyle(
                            color: Colors.white60,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      onChanged: (value) {
                        setState(
                              () {
                            stream = FirebaseFirestore.instance
                                .collection('files')
                                .where('filename',
                                isGreaterThanOrEqualTo: value)
                                .where('filename', isLessThan: value + 'z')
                                .snapshots();
                          },
                        );
                      },
                    );
                  } else {
                    setState(() {
                      stream = FirebaseFirestore.instance
                          .collection('files')
                          .snapshots();
                    });
                    this.cusIcon = Icon(Icons.search);
                    this.cusSearchBar = Text("");
                  }
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: StreamBuilder(
            stream: stream,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return FileListWidget(
                    fileList: FileList(
                      id: ds.id,
                      fileName: ds['filename'],
                      description: ds['description'],
                      downloadUrl: ds['downloadUrl'],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
