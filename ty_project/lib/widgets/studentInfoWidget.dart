import 'package:flutter/material.dart';
import 'package:ty_project/models/studentInfo.dart';

class StudentInfoWidget extends StatefulWidget {
  StudentInfo studentInfo;
  StudentInfoWidget({required this.studentInfo});
  @override
  _StudentInfoWidgetState createState() => _StudentInfoWidgetState();
}

class _StudentInfoWidgetState extends State<StudentInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 9,horizontal:15),
      decoration: BoxDecoration(
          color: Color(0xffBCD2EE),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent,
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(5, 5),
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.person),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  widget.studentInfo.name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.blueGrey,
          )
        ],
      ),
    );
  }
}
