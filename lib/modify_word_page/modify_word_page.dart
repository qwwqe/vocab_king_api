import 'package:flutter/material.dart';
import 'package:vocab_king/models/words.dart';
import 'package:vocab_king/modify_word_page/modify_word_form.dart';
import 'package:vocab_king/widgets/take_picture_screen.dart';
import 'package:camera/camera.dart';

class ModifyWordPage extends StatefulWidget {
  final Word word;

  ModifyWordPage({Key key, this.word}) : super(key: key);

  @override
  _ModifyWordPageState createState() => _ModifyWordPageState();
}

class _ModifyWordPageState extends State<ModifyWordPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Add or modify word"),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: firstCamera == null
                ? null
                : () async {
                  final photoPath = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TakePictureScreen(camera: firstCamera)));
                  if (photoPath != null) {
                    debugPrint(photoPath);
                  }
                },
          ),
        ],
      ),
      body: ModifyWordForm(word: widget.word),
    );
  }
}