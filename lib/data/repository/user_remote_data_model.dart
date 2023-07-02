import 'package:projectritsbook_native/core/firestore_crud_operations.dart';

class UserRemoteDataModel extends FirestoreDocumentModel {
  final String email;

  UserRemoteDataModel({
    required String id,
    required this.email,
  }) : super(id);

  UserRemoteDataModel.fromFireStoreDocument(super.doc)
      : email = (doc['email'] as String),
        super.fromFireStoreDocument();

  @override
  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }
}
