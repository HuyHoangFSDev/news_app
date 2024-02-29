import 'package:bao_moi/models/news.dart';
import 'package:bao_moi/widgets/news_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:diacritic/diacritic.dart';

var data = [];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var newslist = [];

  void setupHomeScreen() async {
    newslist = await listNews();
    setState(() {
      data = newslist;
    });
  }

  void _runFilter(String enteredKeyword) async{
    var results = [];
    if (enteredKeyword.isEmpty) {
      results = newslist;
    } else {
      results = newslist
          .where((news) =>
          removeDiacritics(news.title.toLowerCase()).contains(removeDiacritics(enteredKeyword.toLowerCase())) || removeDiacritics(news.category.toLowerCase()).contains(removeDiacritics(enteredKeyword.toLowerCase())))
          .toList();
    }
    setState(() {
      data = results;
    });
  }
  @override
  void initState() {
    setupHomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.menu, color: Colors.blueAccent,)),
              SizedBox(
                width: 250,
                height: 40,
                child: TextField(
                  onChanged: (value) {
                    _runFilter(value);
                  },
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      labelStyle: TextStyle(fontSize: 12),
                  ),
                  cursorHeight: 25,
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications, color: Colors.blueAccent,))
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: (data.isNotEmpty)
              ? data
                  .map((e) => NewsWidget(
                        news: e,
                      ))
                  .toList()
              : <Widget>[
                  const SizedBox(
                    height: 200,
                  ),
                  const Center(
                      child: SpinKitWanderingCubes(
                    color: Colors.blueAccent,
                    size: 50,
                  ))
                ],
        ));
  }
}
