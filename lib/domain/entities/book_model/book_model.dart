import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
class Book with _$Book {
  const factory Book({
    required String title,
    required String author,
    required String description,
    required String imageUrl,
    required String condition,
    required bool isSold,
    required String documentID,
    required int price,
  }) = _Book;
  
  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
