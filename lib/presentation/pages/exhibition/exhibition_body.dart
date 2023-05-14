import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:projectritsbook_native/domain/entities/book_model.dart';
import 'package:projectritsbook_native/presentation/dialogs/check_login_dialog.dart';
import 'package:projectritsbook_native/presentation/pages/exhibition/pick_image.dart';
import '../../providers.dart';

class ExhibitionPageBody extends ConsumerStatefulWidget {
  const ExhibitionPageBody({Key? key}) : super(key: key);
  @override
  _ExhibitionPageBodyState createState() => _ExhibitionPageBodyState();
}

class _ExhibitionPageBodyState extends ConsumerState<ExhibitionPageBody> {
  _ExhibitionPageBodyState();
  String? condition;
  String? description;
  bool? isSold;
  String? bookName;
  int? price;
  String? seller;
  String? timestamp;
  String? userID;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authStateChangesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "出品画面",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Gap(20),
            const Text("商品情報を入力してください",
                style: TextStyle(
                  fontSize: 16,
                )),
            (imageUrl != null)
                ? Image.network(imageUrl!)
                : Image.asset('images/camera.png'),
            const Gap(20),
            ElevatedButton(
                onPressed: () async {
                  //ログイン状態を確認
                  if (auth != null) {
                    //   //画像を選択
                    //   pickImage().then((value) async {
                    //     //画像をアップロード
                    //     final uploadedImageUrl = await ref
                    //         .read(uploadBookUseCaseProvider)
                    //         .uploadBookImage(value);
                    //     setState(() {
                    //       imageUrl = uploadedImageUrl;
                    //     });
                    //   });
                    checkLoginDialog(context);
                  } else {
                    //ログインしていない場合はログイン画面に遷移
                    checkLoginDialog(context);
                  }
                },
                // if (auth != null){
                //   pickImage().then((value) async {
                //     final uploadedImageUrl = await ref
                //         .read(uploadBookUseCaseProvider)
                //         .uploadBookImage(value);
                //     setState(() {
                //       imageUrl = uploadedImageUrl;
                //     });
                //   });
                // } else {
                //   checkLoginDialog(context);
                // }

                child: const Text('画像を選択')),
            const Gap(20),
            const Text(
              "商品名",
            ),
            SizedBox(
              child: TextField(
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: '商品名',
                    // contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onChanged: (String text) {
                  setState(() {
                    bookName = text;
                  });
                },
              ),
            ),
            const Gap(20),
            const Text("商品の説明"),
            SizedBox(
              child: TextField(
                maxLines: 8,
                decoration: const InputDecoration(
                  hintText: ' 商品の説明\n・教科書の破損状態\n・使用した授業\n  など',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                onChanged: (String text) {
                  setState(() {
                    description = text;
                  });
                },
              ),
            ),
            const Gap(20),
            const Text("商品の状態"),
            SizedBox(
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "商品の状態",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                items: const [
                  DropdownMenuItem(
                    value: '新品・未使用',
                    child: Text('新品・未使用'),
                  ),
                  DropdownMenuItem(
                    value: '未使用に近い',
                    child: Text('未使用に近い'),
                  ),
                  DropdownMenuItem(
                    value: '目立った傷や汚れなし',
                    child: Text('目立った傷や汚れなし'),
                  ),
                  DropdownMenuItem(
                    value: '傷や汚れあり',
                    child: Text('傷や汚れあり'),
                  ),
                  DropdownMenuItem(
                    value: '全体的に状態が悪い',
                    child: Text('全体的に状態が悪い'),
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    condition = value;
                  });
                },
                value: condition,
              ),
            ),
            const Gap(20),
            const Text("値段"),
            SizedBox(
              child: TextField(
                keyboardType: TextInputType.number,
                // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    labelText: '値段',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onChanged: (value) {
                  setState(() {
                    price = int.parse(value);
                  });
                },
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xfff13838),
                    backgroundColor: Colors.white,
                    side:
                        const BorderSide(width: 2.0, color: Color(0xfff13838)),
                  ),
                  onPressed: () async {
                    final book = Book(
                      title: bookName!,
                      author: seller!,
                      description: description!,
                      imageUrl: imageUrl!,
                      condition: condition!,
                      isSold: false,
                      documentID: "",
                      price: price!,
                    );
                    await ref.read(uploadBookUseCaseProvider).uploadBook(book);
                  },
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: const Text("出品する"),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
