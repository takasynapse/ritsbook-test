import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectritsbook_native/data/data_sources/auth_remote_data_sources.dart';
import 'package:projectritsbook_native/data/data_sources/book_remote_data_source.dart';
import 'package:projectritsbook_native/data/repository/auth_repository_impl.dart';
import 'package:projectritsbook_native/data/repository/book_repository_impl.dart';
import 'package:projectritsbook_native/domain/repositories/auth_repository.dart';
import 'package:projectritsbook_native/domain/use_cases/auth/get_user_data_use_case.dart';
import 'package:projectritsbook_native/domain/use_cases/auth/login_use_case.dart';
import 'package:projectritsbook_native/domain/use_cases/auth/sign_up_use_case.dart';
import 'package:projectritsbook_native/domain/use_cases/book/exhibition_book_usecase.dart';
import 'package:projectritsbook_native/domain/use_cases/book/get_book_use_case.dart';
import 'package:riverpod/riverpod.dart';


import '../domain/entities/book_model.dart';

///FireStoreのインスタンスを作成
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

///FireStoreのインスタンスを使って、BookRepositoryを作成
final bookRepositoryProvider = Provider((ref) => BookRepositoryImpl(
    bookRemoteDataSource: BookRemoteDataSourceImpl(
        firebaseFireStore: ref.read(firebaseFirestoreProvider))));

///BookRepositoryを使って、GetAllBooksUseCaseを作成
final getAllBooksUseCaseProvider =
    Provider((ref) => GetAllBooksUseCase(ref.read(bookRepositoryProvider)));

///GetAllBooksUseCaseを使って、出品中のすべての本を取得
final bookFutureProvider = FutureProvider.autoDispose<List<Book>>((ref) async {
  return ref.read(getAllBooksUseCaseProvider).execute();
});

///BookRepositoryを使って、UploadBookUseCaseを作成
final uploadBookUseCaseProvider =
    Provider((ref) => ExhibitionBookUseCase(ref.read(bookRepositoryProvider)));

///UploadBookUseCaseを使って、本を出品
final uploadImageUseCaseProvider =
    Provider((ref) => ExhibitionBookUseCase(ref.read(bookRepositoryProvider)));

///AuthレポジトリのProvider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authRemoteDataSource = AuthRemoteDataSourceImpl(
      FirebaseAuth.instance, FirebaseFirestore.instance);
  return AuthRepositoryImpl(authRemoteDataSource: authRemoteDataSource);
});

///ログインユースケースのProvider
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return LoginUseCase(authRepository);
});

///新規登録ユースケースのProvider
final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return SignUpUseCase(authRepository);
});

///ログイン状態の確認
final authStateChangesProvider = StreamProvider.autoDispose<User?>((ref) {
  final auth = FirebaseAuth.instance;
  return auth.authStateChanges();
});

///自身のユーザー情報を取得するメソッド
final getUserDataUseCaseProvider = Provider<GetUserDataUseCase>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return GetUserDataUseCase(authRepository);
});