import 'package:vocab_king/models/stats.dart';
import 'package:vocab_king/models/words.dart';
import 'package:vocab_king/models/word_list_response.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<StatsOverview> getStatsOverview(http.Client client) async {
  final response = await client.get(Uri.http("100.64.1.17:8585", "/stats"));

  if(response.statusCode == 200) {
    return StatsOverview.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to retrieve stats');
  }
}

Future<List<Word>> getWords(http.Client client) async {
  final response = await client.get(Uri.http("100.64.1.17:8585", "/words"));

  if(response.statusCode == 200) {
    var wordListResponse = WordListResponse.fromJson(json.decode(response.body));
    if(wordListResponse.isSuccess()) {
      return wordListResponse.words;
    } else {
      throw Exception('Failed to retrieve wordlist (invalid action)');
    }
  } else {
    print(response.body);
    throw Exception('Failed to retrieve wordlist');
  }
}