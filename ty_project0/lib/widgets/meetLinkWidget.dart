import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:ty_project0/models/link.dart';
import 'package:url_launcher/url_launcher.dart';

class MeetLinkWidget extends StatefulWidget {
  Link link;
  MeetLinkWidget({required this.link});

  @override
  _MeetLinkWidgetState createState() => _MeetLinkWidgetState();
}

class _MeetLinkWidgetState extends State<MeetLinkWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      margin: EdgeInsets.only(bottom: 20),
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
      child: Material(
        color: Color(0xffBCD2EE),
        child: InkWell(
          onTap: () async {
            final url = widget.link.link;
            print(url);
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.link.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        widget.link.link,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Material(
                            color: Color(0xffBCD2EE),
                            child: InkWell(
                              onTap: () {
                                Share.share(widget.link.link);
                              },
                              splashColor: Colors.white30,
                              child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.black),
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Color(0xffBCD2EE),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black,
                                          spreadRadius: 0.8,
                                          offset: Offset(1, 1),
                                        )
                                      ]),
                                  child: Icon(Icons.share)),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
