import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Title"),),
      body: Center(
        child: MaterialButton(
          onPressed: (){
            _getFromGallery(context);
          },
          child: Text("Pick Image"),
        ),
      ),
    );
  }

  /// Get from gallery
  Future<void> _getFromGallery(context) async {
    try {
      XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
      }
    } catch (e) {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        print('Access Denied');
        showAlertDialog(context);
      } else {
        print('Exception occured!');
      }
    }
  }

  showAlertDialog(context) => showCupertinoDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Permission Denied'),
      content: const Text('Allow access to gallery and photos'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => openAppSettings(),
          child: const Text('Settings'),
        ),
      ],
    ),
  );
}
