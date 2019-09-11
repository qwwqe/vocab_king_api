import 'package:flutter/material.dart';
import 'package:vocab_king/widgets/take_picture_screen.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:vocab_king/widgets/show_photo_screen.dart';
//import 'package:image/image.dart';

class FatPhotoFormField extends StatefulWidget {
  final void Function(List<String>) onPhotosUpdated;

  FatPhotoFormField({Key key, this.onPhotosUpdated}) : super(key: key);

  @override
  _FatPhotoFormFieldState createState() => _FatPhotoFormFieldState();
}

class _FatPhotoFormFieldState extends State<FatPhotoFormField> {
  List<String> photos = [];
  List<CameraDescription> cameras;
  CameraDescription firstCamera;

  @override
  void initState() {
    availableCameras().then((descriptions) {
      setState(() {
        cameras = descriptions;
        firstCamera = cameras.first;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if(photos.length > 0) {
      children = List<Widget>.generate(photos.length, (i) {
        return GestureDetector(
          onTap: () async {
            bool delete = await Navigator.push(context, MaterialPageRoute(
                builder: (context) => ShowPhotoScreen(photoPath: photos[i])));
            if(delete != null && delete) {
              setState(() {
                photos.removeAt(i);
              });
            }
          },
          child: Container(
              margin: EdgeInsets.fromLTRB(0,0,0,24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.black),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.file(File(photos[i]), fit: BoxFit.fill),
              ),
          ),
        );
      });
    }

    children.add(
      GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[300],
          ),
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Icon(Icons.photo_camera),
        ),
        onTap: firstCamera == null
            ? null
            : () async {
          final photoPath = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera)));
          if (photoPath != null) {
            debugPrint(photoPath);
            setState(() {
              photos.add(photoPath);
            });
          }
        },
      ),
    );

    return Container(
      decoration: BoxDecoration(

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}