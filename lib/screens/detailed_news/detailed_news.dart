import 'package:bao_moi/models/news.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailNews extends StatefulWidget {
  const DetailNews({Key? key}) : super(key: key);

  @override
  State<DetailNews> createState() => _DetailNewsState();
}

class _DetailNewsState extends State<DetailNews> {
  late News args;
  bool isLiked = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)?.settings.arguments as News;
    loadData();
  }

  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String uniqueKey = 'like_${args.id}';

    setState(() {
      args.like = prefs.getInt(uniqueKey) ?? args.like;
      isLiked = prefs.getBool('isLiked_$uniqueKey') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.bookmark_border),
              SizedBox(
                width: 15,
              ),
              Icon(Icons.ios_share)
            ],
          ),
        ),
      ),
      body: ListView(children: [
        Image(image: AssetImage(args.image)),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      args.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final String uniqueKey = 'like_${args.id}';
                      setState(() {
                        isLiked = !isLiked;
                        var likes = prefs.getInt(uniqueKey) ?? args.like;
                        if (likes < 100) {
                          likes += isLiked ? 1 : -1;
                          prefs.setInt(uniqueKey, likes);
                          args.like = likes;
                          prefs.setBool('isLiked_$uniqueKey', isLiked);
                        }
                      });
                    },
                    icon:
                        Icon(isLiked ? Icons.favorite : Icons.favorite_outline),
                    padding: EdgeInsets.zero,
                  ),
                  Text(
                    '${args.like} lượt ${(args.like <= 1 ? 'like' : 'likes')}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(args.content, textAlign: TextAlign.justify),
            ],
          ),
        )
      ]),
    );
  }
}
