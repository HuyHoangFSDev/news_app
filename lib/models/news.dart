import '../data/news_data.dart';

class News {
  int id;
  String image;
  String title;
  String description;
  int like;
  String content;
  String category;

  News(this.id, this.image, this.title, this.description, this.like, this.content,
      this.category);
}

Future<List> listNews() {
  return Future.delayed(const Duration(seconds: 2),() => newsdata);
}

Future<News> getNewsById(int id) {
  return Future.delayed(const Duration(seconds: 2), () => newsdata.firstWhere((element) => element.id == id));
}