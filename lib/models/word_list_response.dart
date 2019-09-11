import 'package:vocab_king/models/words.dart';

class WordListResponse {
  static const String _SUCCESS_STATUS = "success";

  String status;
  List<Word> words;

  WordListResponse({this.status, this.words});

  factory WordListResponse.fromJson(Map<String, dynamic> json) {
    String _status = json['status'];
    List<Word> _data = [];

    if(_status == _SUCCESS_STATUS && json['data'] != null) {
      var _words = json['data'] as List;
      _data = _words.map((w) {
        return Word.fromJson(w);
      }).toList();
    }

    return WordListResponse(
      status: _status,
      words: _data,
    );
  }

  bool isSuccess() {
    return status == _SUCCESS_STATUS;
  }
}