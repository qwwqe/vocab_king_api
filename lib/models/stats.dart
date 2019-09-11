import 'package:vocab_king/models/words.dart';

class StatsOverview {
  int nWords;
  int nDefinitions;
  int nUndefinedWords;

  int nPhrases;
  int nTopics;
  int nNotes;

  //List<Word> undefinedWords;
  //List<Word> untaggedWords;
  List<String> undefinedWords;
  List<String> untaggedWords;

  StatsOverview({
    this.nWords, this.nDefinitions, this.nUndefinedWords,
    this.nPhrases, this.nTopics, this.nNotes,
    this.undefinedWords, this.untaggedWords
  });

  factory StatsOverview.fromJson(Map<String, dynamic> json) {
    var undefinedWords = json['undefined_words'];
    var untaggedWords = json['untagged_words'];
    return StatsOverview(
      nWords: json['num_words'],
      nDefinitions: json['num_definitions'],
      nUndefinedWords: json['num_undefined_words'],
      nPhrases: json['num_phrases'],
      nTopics: json['num_topics'],
      nNotes: json['num_notes'],
      undefinedWords: List<String>.from(undefinedWords),
      untaggedWords: List<String>.from(untaggedWords),
    );
  }
}