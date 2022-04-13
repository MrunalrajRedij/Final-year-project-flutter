import 'package:flutter/material.dart';
import 'package:ty_project/data_activities_helper.dart';

class MeetingLinksPage extends StatefulWidget {
  @override
  _MeetingLinksPageState createState() => _MeetingLinksPageState();
}

class _MeetingLinksPageState extends State<MeetingLinksPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var classTitle;
  var classLink;
  var selectedClass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Image(
                          image: AssetImage('assets/images/meetings.png'),
                        ),
                      ),
                      SizedBox(height: 30),
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
                            SizedBox(height: 5),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffe5e4e2),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0))),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Enter title",
                                  prefixIcon:
                                      Icon(Icons.drive_file_rename_outline),
                                ),
                                validator: (input) {
                                  if (input == null) {
                                    return "Enter title";
                                  }
                                },
                                onChanged: (input) => classTitle = input,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color(0xffe5e4e2),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0))),
                              child: TextFormField(
                                validator: (input) {
                                  if (input == null) {
                                    return "Enter link";
                                  }
                                },
                                onChanged: (input) => classLink = input,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: "Enter link",
                                  prefixIcon: Icon(Icons.link),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            ElevatedButton(
                              onPressed: () async {
                                await DatabaseHelper.uploadLink(
                                    classTitle, classLink);
                                final uploadingCompletedSnackBar = SnackBar(
                                    content:
                                        Text("Link successfully uploaded!"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(uploadingCompletedSnackBar);
                              },
                              child: Text("Upload Link"),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.blueAccent),
                              ),
                            ),
                          ],
                        ),
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
}
