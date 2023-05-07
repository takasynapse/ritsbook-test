import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ExhibitionPage extends StatelessWidget {
  const ExhibitionPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Gap(20),
            const Text("商品情報を入力してください",
                style: TextStyle(
                  fontSize: 16,
                )),
            Image.asset('images/camera.png'),
            const ElevatedButton(onPressed: null, child: Text('画像を選択')),
            const Text("商品名(必須)",
                style: TextStyle(
                  color: Color(0xff8f8f8f),
                )),
            SizedBox(
              width: 300,
              child: TextField(
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: '商品名',
                    // contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    )),
                onChanged: (String text) {
                  // setState(() {
                  //   item = text;
                  // });
                },
              ),
            ),
            const SizedBox(
              width: 300,
              child: TextField(
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: ' 商品の説明\n・教科書の破損状態\n・使用した授業\n  など',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                // onChanged: (String text) {
                //   setState(() {
                //     description = text;
                //   });
                // },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("商品の状態"),
            SizedBox(
              width: 300,
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
                onChanged: (String? value) {},
                // onChanged: (String? value) {
                //   setState(() {
                //     condition = value;
                //   });
                // },
                // value: condition,
              ),
            ),
            const Text("値段"),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                keyboardType: TextInputType.number,
                // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    labelText: '値段',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onChanged: (value) {},
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color(0xfff13838),
                    backgroundColor: Colors.white,
                    side:
                        const BorderSide(width: 2.0, color: Color(0xfff13838)),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: const Text("出品する"),
                ),
              ),
            )
          ]),
        ),
      ),
    ));
  }
}
