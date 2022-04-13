import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ty_project/screens/loginPage.dart';
import '../data_activities_helper.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _name, _firstName, _lastName, _email, _pass, _conPass, _mob;

  signUp() async {
    _name = await _firstName + _lastName;

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _auth.createUserWithEmailAndPassword(
            email: _email, password: _pass);
        await _auth.currentUser!.updateDisplayName(_name);

        _auth.authStateChanges().listen((user) {
          UserHelper.saveUser(user!, _firstName, _lastName, _mob);
        });

        await _auth.signOut();

        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => LoginPage(),
          ),
        );
      } on FirebaseException catch (e) {
        showError(e.message ?? "Error");
      }
    }
  }

  showError(String errormessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffe5e4e2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: TextFormField(
                              onChanged: (input) {
                                _firstName = input;
                              },
                              validator: (input) {},
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'First Name',
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffe5e4e2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: TextFormField(
                              onChanged: (input) {
                                _lastName = input;
                              },
                              validator: (input) {},
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Last Name',
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffe5e4e2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: TextFormField(
                              onChanged: (input) {
                                _email = input;
                              },
                              validator: (input) {
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(input!)) {
                                  return "Enter valid email";
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffe5e4e2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: TextFormField(
                              onChanged: (input) {
                                _mob = input;
                              },
                              validator: (input) {
                                if (!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                                        .hasMatch(input!) ||
                                    input.length < 10) {
                                  return "Enter valid Mobile Number";
                                }
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Mobile Number',
                                prefixIcon: Icon(Icons.phone),
                              ),
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffe5e4e2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: TextFormField(
                              onChanged: (input) {
                                _pass = input;
                              },
                              validator: (input) {},
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                              obscureText: true,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffe5e4e2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: TextFormField(
                              onChanged: (input) {
                                _conPass = input;
                              },
                              validator: (input) {
                                if (_pass != _conPass)
                                  return "Password mismatched";
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Confirm Password',
                                prefixIcon: Icon(Icons.lock),
                              ),
                              obscureText: true,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () => signUp(),
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.blueAccent),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ))),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
