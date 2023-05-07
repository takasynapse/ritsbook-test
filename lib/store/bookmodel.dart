

class BookModel {
  String title;
  String author;
  String description;
  String imageUrl;
  String url;
  String condition;
  bool isSold ;

  BookModel({
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
    required this.url,
    required this.condition,
    required this.isSold,
  });
}