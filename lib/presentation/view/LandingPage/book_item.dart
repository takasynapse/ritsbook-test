import 'package:flutter/material.dart';
import 'package:projectritsbook_native/data/models/book_model.dart';

class BookItem extends StatefulWidget {
  BookItem({Key? key, required this.book}) : super(key: key);
  final Book book;
  @override
  _BookItemState createState() => _BookItemState(book: book);
}

class _BookItemState extends State<BookItem> {
  _BookItemState({Key? key, required this.book});
  final Book book;
  final _key = GlobalKey();
  double height = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        height = _key.currentContext!.size!.height;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: _key,
      clipBehavior: Clip.antiAlias,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: height * 0.7,
            child: Image.network(
              book.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: height * 0.2,
            width: double.infinity,
            child: Text(
              book.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
