import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promina_assign/res/text_widget.dart';
import 'package:promina_assign/view_model/home_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ImagePickOptions extends StatefulWidget {
  final type;

  ImagePickOptions(this.type);

  @override
  State<ImagePickOptions> createState() => _ImagePickOptionsState(this.type);
}

class _ImagePickOptionsState extends State<ImagePickOptions> {
  var screen;

  _ImagePickOptionsState(this.type);
  var _image;
  var imagePicker;
  var type;
  var path;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
  }

  HomeViewModel homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.pink[50],
          title: TextUtils(
            text: type == ImageSource.camera
                ? "Image from Camera"
                : "Image from Gallery",
            color: Colors.black,
          )),
      body: ListView(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  print('tapped');
                  var source = type == ImageSource.camera
                      ? ImageSource.camera
                      : ImageSource.gallery;
                  XFile image = await imagePicker.pickImage(
                      source: source,
                      imageQuality: 50,
                      preferredCameraDevice: CameraDevice.front);
                  setState(() {
                    print('pathhhhhh' + image.path);
                    path = image.path;
                    _image = File(image.path);
                  });
                },
                child: _image != null
                    ? Container(
                        height: size.height - 100,
                        width: size.width,
                        child: Image.file(
                          _image,
                          width: size.width,
                          height: size.height,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 50),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 120,
                          child: Icon(
                            type == ImageSource.camera
                                ? Icons.camera_alt
                                : Icons.photo_library,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 220, 166, 230),
        onPressed: () async {
          if (path != null) {
            // await uploadImage(path);
            homeViewModel.uploadImage(path).then((value) {
              value == true
                  ? Navigator.of(context).pop()
                  : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('error while uploading'),
                    ));
              ;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(type == ImageSource.camera
                  ? "Please capture photo"
                  : 'Please pick image from gallery'),
            ));
          }
          // Navigator.pop(context);
        },
        child: Icon(
          Icons.file_upload,
          color: Colors.white,
        ),
      ),
    );
  }

  upload(path, screen) async {}
}
