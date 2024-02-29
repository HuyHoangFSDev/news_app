import 'package:bao_moi/models/news.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsWidget extends StatefulWidget {
  final dynamic news;

  const NewsWidget({Key? key, required this.news}) : super(key: key);

  @override
  _NewsWidgetState createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void navigate() {
    News args = News(
        widget.news.id,
        widget.news.image,
        widget.news.title,
        widget.news.description,
        widget.news.like,
        widget.news.content,
        widget.news.category);
    Navigator.pushNamed(context, '/detailnews', arguments: args);
  }

  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String uniqueKey = 'like_${widget.news.id}';

    setState(() {
      widget.news.like = prefs.getInt(uniqueKey) ?? widget.news.like;
      isLiked = prefs.getBool('isLiked_$uniqueKey') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: navigate,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: AssetImage(widget.news.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                color: Color.fromRGBO(248, 248, 248, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            onTap: navigate,
                            child: Text(
                              widget.news.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.more_vert,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: Colors.indigoAccent,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              'Huy Hoang',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Icon(
                            Icons.check_circle,
                            color: Colors.blueAccent,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: widget.news.content,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                            ]),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: IconButton(
                                onPressed: () async {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  final String uniqueKey =
                                      'like_${widget.news.id}';

                                  setState(() {
                                    isLiked = !isLiked;
                                    var likes = prefs.getInt(uniqueKey) ??
                                        widget.news.like;
                                    if (likes < 100) {
                                      likes += isLiked ? 1 : -1;
                                      prefs.setInt(uniqueKey, likes);
                                      widget.news.like = likes;
                                      prefs.setBool(
                                          'isLiked_$uniqueKey', isLiked);
                                    }
                                  });
                                },
                                icon: Icon(isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_outline),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(Icons.chat_bubble_outline)),
                            const SizedBox(
                              width: 20,
                            ),
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: Icon(Icons.share_outlined),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '${widget.news.like} ${(widget.news.like <= 1 ? 'like' : 'likes')}',
                              style: const TextStyle(fontSize: 8),
                            ),
                            const Icon(
                              Icons.fiber_manual_record,
                              size: 15,
                            ),
                            const Text(
                              '4.5 Views',
                              style: TextStyle(fontSize: 8),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
