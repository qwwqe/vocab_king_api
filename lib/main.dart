import 'package:flutter/material.dart';
import 'dart:async';
import 'package:vocab_king/home_tab/home_tab_page.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:vocab_king/widgets/extended_fab.dart';
import 'package:vocab_king/words_tab/words_tab_page.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vocab King',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tabContents = <Widget> [
    //Center(child: Icon(Icons.home, size: 64.0)),
    HomeTabPage(),
    WordsTabPage(),
    Center(child: Icon(Icons.chat_bubble, size: 64.0)),
    Center(child: Icon(Icons.free_breakfast, size: 64.0)),
  ];

  final _tabs = <Tab> [
    Tab(icon: Icon(Icons.home), text: "Home"),
    Tab(icon: Icon(Icons.font_download), text: "Words"),
    Tab(icon: Icon(Icons.chat_bubble), text: "Phrases"),
    Tab(icon: Icon(Icons.free_breakfast), text: "Topics"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.black26,
            child: SafeArea(

              child: TabBar(tabs: _tabs),
              ),
            ),
          ),
        body: TabBarView(
          children: _tabContents,
        ),
        floatingActionButton: ExtendedFab(),
      ),
    );
  }
}
