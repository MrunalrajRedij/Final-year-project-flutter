import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseApi {
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
