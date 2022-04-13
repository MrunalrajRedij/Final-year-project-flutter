import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ty_project/models/fileList.dart';

class FirebaseApi {
  static uploadFile(String description, File file) async {
    try {
      final fileName = basename(file.path);
      final ref = FirebaseStorage.instance.ref("files/${fileName}");
      Task task = ref.putFile(file);
      final snapshot = await task.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      await FirebaseFirestore.instance.collection("files").doc().set({
        "filename": fileName,
        "downloadUrl": downloadUrl,
        "description": description
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static Future downloadFile(String name, String url) async {
    final perStatus = await Permission.storage.request();
    if (perStatus.isGranted) {
      var dir = await getExternalStorageDirectory();
      String newPath = "";
      List<String> folders = await dir!.path.split("/");
      for (int x = 1; x < folders.length; x++) {
        String folder = folders[x];
        if (folder != "Android") {
          newPath += "/" + folder;
        } else {
          break;
        }
      }
      newPath = newPath + "/PocketCollege";
      dir = await new Directory(newPath).create();
      print(dir.path);
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: dir.path,
        showNotification: true,
        openFileFromNotification: true,
        fileName: name,
      );
    } else {
      print("Grant Permission");
    }
  }

}
