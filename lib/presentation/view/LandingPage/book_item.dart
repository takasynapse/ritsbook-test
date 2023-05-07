import 'package:flutter/material.dart';
import 'package:projectritsbook_native/data/models/book_model.dart';
import 'package:projectritsbook_native/presentation/view/bookdetail.dart';

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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(selectedBook: book),
          ),
        );
      },
      child: Card(
          key: _key,
          clipBehavior: Clip.antiAlias,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: (book.isSold)
              ? Column(
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
                )
              :
              //売り切れの商品は画像をグレーにする
              Stack(children: [
                  const Center(
                      child: Text(
                    "売り切れ",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  )),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: height * 0.7,
                        child: Image.network(
                          book.imageUrl,
                          fit: BoxFit.cover,
                          color: Colors.grey,
                          colorBlendMode: BlendMode.saturation,
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
                ])),
    );
  }
}
