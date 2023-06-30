// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: non_constant_identifier_names
_$_Book _$$_BookFromJson(Map<String, dynamic> json) => _$_Book(
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      condition: json['condition'] as String,
      isSold: json['isSold'] as bool,
      documentID: json['documentID'] as String,
      price: json['price'] as int,
    );

// ignore: non_constant_identifier_names
Map<String, dynamic> _$$_BookToJson(_$_Book instance) => <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'condition': instance.condition,
      'isSold': instance.isSold,
      'documentID': instance.documentID,
      'price': instance.price,
    };
