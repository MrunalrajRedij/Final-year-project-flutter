import 'package:flutter/material.dart';

class IndividualStudentInfo extends StatefulWidget {
  final firstName, lastName, email, phoneNum, address;
  IndividualStudentInfo(
      {this.firstName, this.lastName, this.email, this.phoneNum, this.address});

  @override
  _IndividualStudentInfoState createState() => _IndividualStudentInfoState();
}

class _IndividualStudentInfoState extends State<IndividualStudentInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 100, right: 100, top: 10),
                child: Image(
                  image: AssetImage('assets/images/profile.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "Personal Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xffBCD2EE),
                    border: Border.all(
                      width: 8,
                      color: Color(0xffBCD2EE),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 4),
                          child: Container(
                            height: 60,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Text(
                                      "First Name :  ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.firstName,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(width: 1),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 4),
                          child: Container(
                            height: 60,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Text(
                                      "Last Name :  ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.lastName,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(width: 1),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 4),
                          child: Container(
                            height: 60,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Text(
                                      "E-mail :  ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.email,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(width: 1),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 4),
                          child: Container(
                            height: 60,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Text(
                                      "Phone Number :  ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.phoneNum,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(width: 1),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 4),
                          child: Container(
                            height: 60,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Text(
                                      "Address :  ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      widget.address,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(width: 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
