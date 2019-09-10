import 'package:flutter/material.dart';
import 'package:vocab_king/widgets/take_picture_screen.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
//import 'package:image/image.dart';

class PhotoFormField extends StatefulWidget {
  final void Function(List<String>) onPhotosUpdated;

  PhotoFormField({Key key, this.onPhotosUpdated}) : super(key: key);

  @override
  _PhotoFormFieldState createState() => _PhotoFormFieldState();
}

class _PhotoFormFieldState extends State<PhotoFormField> {
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
        return Image.file(File(photos[i]), height: 150);
      });
    }

    children.addAll([
      Spacer(),
      // TODO: add touch animation
      GestureDetector(
        child: Icon(Icons.photo_camera, size: 30),
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
      SizedBox(width: 5),
    ]);

    return Container(
      decoration: BoxDecoration(

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: children,
      ),
    );
  }
}