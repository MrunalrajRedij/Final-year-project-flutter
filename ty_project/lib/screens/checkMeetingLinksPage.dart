import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ty_project/models/link.dart';
import 'package:ty_project/widgets/meetLinkWidget.dart';

class CheckMeetingLinksPage extends StatefulWidget {
  @override
  _CheckMeetingLinksPageState createState() => _CheckMeetingLinksPageState();
}

class _CheckMeetingLinksPageState extends State<CheckMeetingLinksPage> {
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("");
  var stream;

  @override
  void initState() {
    super.initState();
    stream = FirebaseFirestore.instance.collection('meetingLinks').snapshots();
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
              setState(() {
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
                              .collection('meetingLinks')
                              .where('title', isGreaterThanOrEqualTo: value)
                              .where('title', isLessThan: value + 'z')
                              .snapshots();
                        },
                      );
                    },
                  );
                } else {
                  setState(() {
                    stream = FirebaseFirestore.instance
                        .collection('meetingLinks')
                        .snapshots();
                  });
                  this.cusIcon = Icon(Icons.search);
                  this.cusSearchBar = Text("");
                }
              });
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
                  return MeetLinkWidget(
                    link: Link(
                      id: ds.id,
                      title: ds['title'],
                      link: ds['link'],
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
