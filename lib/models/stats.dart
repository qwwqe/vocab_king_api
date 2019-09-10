import 'package:vocab_king/models/words.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

Future<StatsOverview> getStatsOverview(http.Client client) async {
  final response = await client.get(Uri.http("100.64.1.17:8585", "/stats"));

  if(response.statusCode == 200) {
    return StatsOverview.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to retrieve stats');
  }
}