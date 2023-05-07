class Book {
  String title;
  String author;
  String description;
  String imageUrl;
  String condition;
  bool isSold;
  String documentID;
  int price;

  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.imageUrl,
    required this.condition,
    required this.isSold,
    required this.documentID,
    required this.price,
  });
}