import 'package:flutter/material.dart';
import 'package:vocab_king/models/stats.dart';
import 'package:vocab_king/models/words.dart';
import 'package:http/http.dart' as http;
import 'package:vocab_king/home_tab/panels.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage({Key key}) : super(key: key);

  @override
  _HomeTabPageState createState() =>_HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  Future<StatsOverview> statsOverview;

  @override
  void initState() {
    super.initState();
    statsOverview = getStatsOverview(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: FutureBuilder<StatsOverview>(
          future: statsOverview,
          builder: (context, snapshot) {

            if(snapshot.hasError) {
              print(snapshot.error.toString());
              return Center(
                child: Icon(Icons.error),
              );
            }

            return Column(
              children: [
                StatsPanel(statsOverview: snapshot.hasData ? snapshot.data : null),
                //UndefinedWordsPanel(undefinedWords : snapshot.hasData ? snapshot.data.undefinedWords : null),
                //UntaggedWordsPanel(untaggedWords: snapshot.hasData ? snapshot.data.untaggedWords : null),
                UndefinedWordsPanel(undefinedWords : snapshot.hasData ? snapshot.data.undefinedWords.map((s) => Word(value:s)).toList() : null),
                UntaggedWordsPanel(untaggedWords: snapshot.hasData ? snapshot.data.untaggedWords.map((s) => Word(value:s)).toList() : null),
              ],
            );
          }
      ),
    );
  }
}