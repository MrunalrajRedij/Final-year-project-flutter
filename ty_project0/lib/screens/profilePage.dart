import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ty_project0/data_activities_helper.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var firstName, lastName, email, phoneNum, address;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return Container(
            color: Colors.white,
            width: double.infinity,
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 100, right: 100),
                            child: Image(
                              image: AssetImage('assets/images/profile.png'),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffe5e4e2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    child: TextFormField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: snapshot.data['firstName'] ??
                                            "{Not assigned}",
                                        prefixIcon: Icon(Icons.person),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffe5e4e2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    child: TextFormField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: snapshot.data['lastName'] ??
                                            "{Not assigned}",
                                        prefixIcon: Icon(Icons.person),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffe5e4e2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    child: TextFormField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: snapshot.data['email'] ??
                                            "{Not assigned}",
                                        prefixIcon: Icon(Icons.email),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffe5e4e2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: snapshot.data['phoneNum'] ??
                                            "{Not assigned}",
                                        prefixIcon: Icon(Icons.phone),
                                      ),
                                      keyboardType: TextInputType.phone,
                                      onChanged: (input) {
                                        phoneNum = input;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffe5e4e2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: snapshot.data['address'] ??
                                            "{Not assigned}",
                                        prefixIcon: Icon(Icons.home),
                                      ),
                                      onChanged:(input){ address = input;},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 30.0,
                        right: 30.0,
                        child: FloatingActionButton(
                          onPressed: () {
                            phoneNum = phoneNum ?? snapshot.data['phoneNum'];
                            if (!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                                .hasMatch(phoneNum) ||
                                phoneNum.length < 10) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Text(
                                          "Enter valid Phone Number"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context);
                                            },
                                            child: Text("OK"))
                                      ],
                                    );
                                  });
                            }else{
                              address = address ?? snapshot.data['address'];
                              user = _auth.currentUser;
                              DatabaseHelper.saveUserInfo(
                                  user,phoneNum, address);
                            }
                          },
                          child: Icon(Icons.save),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
