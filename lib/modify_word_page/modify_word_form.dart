import 'package:flutter/material.dart';
import 'package:vocab_king/models/words.dart';
import 'package:vocab_king/widgets/tag_form_field.dart';
import 'package:vocab_king/widgets/photo_form_field.dart';
import 'package:vocab_king/widgets/fat_photo_form_field.dart';

class ModifyWordForm extends StatefulWidget {
  final Word word;

  ModifyWordForm({Key key, this.word}) : super(key: key);

  @override
  _ModifyWordFormState createState() => _ModifyWordFormState();
}

class _ModifyWordFormState extends State<ModifyWordForm> {
  String _wordText;
  String _pronunciation;
  String _definition;
  List<String> _tags = [];
  List<String> _photos = [];
  String _note;

  @override
  Widget build(context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 24.0),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              labelText: "Word",
            ),
            onSaved: (String value) {
              this._wordText = value;
            }
          ),
          SizedBox(height: 24.0),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              labelText: "Pronunciation",
            ),
            onSaved: (String value) {
              this._pronunciation = value;
            },
          ),
          SizedBox(height: 24.0),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              filled: true,
              labelText: "Definition",
            ),
            onSaved: (String value) {
              this._definition = value;
            },
          ),
          SizedBox(height: 24.0),
          TagFormField(
              onTagsUpdated: (List<String> tags) {
                setState(() {
                  this._tags = List.from(tags);
                });
              }
          ),
          SizedBox(height: _tags.length > 0 ? 10 : 24.0),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              filled: false,
              labelText: "Note",
            ),
            enableInteractiveSelection: true,
            maxLines: 5,
            onSaved: (String value) {
              this._note = value;
            },
          ),
          SizedBox(height: _photos.length > 0 ? 10 : 24.0),
          //PhotoFormField(),
          FatPhotoFormField(
            onPhotosUpdated: (List<String> photos) {
              setState(() {
                this._photos = List.from(photos);
              });
            },
          ),
          SizedBox(height: 12.0),
        ],
      ),
    );
  }
}