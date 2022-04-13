import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;
  static saveUser(User user,String firstName,String lastName,String phone) async {
    Map<String, dynamic> userData = {
      "name": user.displayName,
      "firstName":firstName,
      "lastName":lastName,
      "email": user.email,
      "phoneNum": phone,
      "role": "students",
      "address": "",
    };
    final userRef = _db.collection("users").doc(user.uid);
    if (!(await userRef.get()).exists) {
      await _db.collection("users").doc(user.uid).set(userData);
    } else {
      await _db
          .collection("users")
          .doc(user.uid)
          .set({"name": user.displayName}, SetOptions(merge: true));
    }
  }
}

class DatabaseHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static saveUserInfo(
      User? user,
    String phoneNum,
    String address,
  ) async {
    Map<String,dynamic> userData = {
      "phoneNum": phoneNum,
      "address": address,
    };
    final userRef = _db.collection("users").doc(user?.uid);
    await userRef.update(userData);
  }
}
