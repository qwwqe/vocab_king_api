import 'dart:io';
import 'dart:async';
import 'package:path/path.dart' show join;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;

  TakePictureScreen({Key key, this.camera}) : super(key: key);

  @override
  _TakePictureScreenState createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen>
  with SingleTickerProviderStateMixin {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  AnimationController _animationController;

  @override
  void initState() {
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: CameraPreview(_controller),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.camera_alt),
              onPressed: () async {
                try {
                  final path = join(
                    //(await getTemporaryDirectory()).path,
                    (await getExternalStorageDirectory()).path,
                    '${DateTime.now()}.png'
                  );

                  await _controller.takePicture(path);
                  Navigator.pop(context, path);
                } catch (e) {
                  debugPrint(e);
                  Navigator.pop(context, null);
                }
              },
            ),
          );
        } else {
          return FadeTransition(
            opacity: _animationController,
            child: Center(
              child: Icon(Icons.photo_camera, size: 48),
            )
          );
        }
      },
    );
  }
}