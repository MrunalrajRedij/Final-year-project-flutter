import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ty_project/models/studentInfo.dart';
import 'package:ty_project/screens/individualStudentInfoPage.dart';
import 'package:ty_project/widgets/studentInfoWidget.dart';

class StudentInfoPage extends StatefulWidget {
  @override
  _StudentInfoPageState createState() => _StudentInfoPageState();
}

class _StudentInfoPageState extends State<StudentInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(5),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IndividualStudentInfo(
                              firstName: ds['firstName'],
                              lastName: ds['lastName'],
                              email: ds['email'],
                              phoneNum: ds['phoneNum'],
                              address: ds['address'],
                            ),
                          ),
                        );
                      },
                      child: StudentInfoWidget(
                        studentInfo: StudentInfo(
                          name: ds['name'],
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
