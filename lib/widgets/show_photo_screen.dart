import 'package:flutter/material.dart';
import 'dart:io';

class ShowPhotoScreen extends StatelessWidget {
  final String photoPath;

  ShowPhotoScreen({Key key, this.photoPath}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Image.file(File(photoPath)),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: IconButton(
              iconSize: 30,
              color: Colors.white,
              icon: Icon(Icons.delete),
              onPressed: () => Navigator.pop(context, true),
            ),
          ),
        ],
      ),
    );
  }
}