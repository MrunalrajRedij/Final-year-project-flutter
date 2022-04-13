import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ty_project0/screens/homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _email,_password;

  login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } on FirebaseException catch (e) {
        showError(e.message ?? "Error");
      }
    }
  }

  showError(String errormessage) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(errormessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 90),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/login.png'),
                  ),
                  SizedBox(height: 40),
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
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xffe5e4e2),
                                borderRadius: BorderRadius.all(Radius.circular(20.0))),
                            child: TextFormField(
                              validator: (input) {
                                if(input == null){
                                  return "Enter Email";
                                }
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email)),
                              onSaved: (input) => _email = input,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xffe5e4e2),
                                borderRadius: BorderRadius.all(Radius.circular(20.0))),
                            child: TextFormField(
                              validator: (input) {
                                if(input!.length < 6){
                                  return "Enter valid password";
                                }
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock)),
                              obscureText: true,
                              onSaved: (input)=> _password = input,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () => login(),
                            child: Text("LOGIN"),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
