import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:projectritsbook_native/core/validation/email_validation.dart';
import 'package:projectritsbook_native/core/validation/password_validation.dart';
import 'package:projectritsbook_native/domain/entities/user_model.dart';
import 'package:projectritsbook_native/presentation/dialogs/success_sign_up_dialog.dart';
import 'package:projectritsbook_native/presentation/pages/sign_up/sign_up_view_model.dart';
import 'package:projectritsbook_native/presentation/providers.dart';

class SignUpPage extends ConsumerWidget {
  SignUpPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _mailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final selectedItemProvider = StateProvider<String>((ref) {
    return '選択してください';
  });
  final selectedGradeProvider = StateProvider<String>((ref) {
    return '選択してください';
  });
  final signUpViewModelProvider =
      ChangeNotifierProvider<SignUpViewModel>((ref) {
    final signUpUseCase = ref.watch(signUpUseCaseProvider);
    return SignUpViewModel(signUpUseCase);
  });
  final facultyList = <String>[
    '選択してください',
    '情報理工学部情報理工学科',
    '経済学部経済学科国際専攻',
    '経済学部経済学科経済専攻',
    'スポーツ健康科学部スポーツ健康科学科',
    '食マネジメント学部食マネジメント学科',
    '理工学部電子情報工学科',
    '理工学部数理学科',
    '理工学部物理科学科',
    '理工学部電気電子工学科',
    '理工学部機械工学科',
    '理工学部ロボティクス学科',
    '理工学部環境都市工学科',
    '理工学部建築都市デザイン学科',
    '生命科学部応用化学科',
    '生命科学部生物工学科',
    '生命科学部生命情報学科',
    '生命科学部生命医科学科',
    '薬学部薬学科',
    '薬学部創薬科学科',
  ];
  final gradeList = <String>[
    '選択してください',
    '1年',
    '2年',
    '3年',
    '4年',
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          color: const Color(0xffff6b6b),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              // 画面サイズに合わせて変化する
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Gap(10),
                    Container(
                      color: Colors.white,
                      width: 258,
                      height: 64,
                      child: const Center(
                        child: Text(
                          'RITSBOOK',
                          style: TextStyle(
                            color: Color(0xff484848),
                            fontSize: 34,
                            letterSpacing: 10.44,
                          ),
                        ),
                      ),
                    ),
                    const Gap(60),
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "メールアドレス",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),

                          TextFormField(
                            style: const TextStyle(fontSize: 12),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'メールアドレスを入力',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
                            ),
                            controller: _mailAddressController,
                            validator: (value) {
                              return EmailValidator.validate(value!);
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const Gap(8),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "パスワード",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          const Gap(8),
                          SizedBox(
                            height: 33,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 12),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "パスワードを作成",
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                              ),
                              // パスワードガ見えないようにする
                              obscureText: true,
                              controller: _passwordController,
                              validator: (value) {
                                return PassWordValidator.validate(value!);
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Text(infoText),
                          const SizedBox(height: 15),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("ユーザ名", style: TextStyle(fontSize: 12)),
                          ),
                          SizedBox(
                            height: 33,
                            child: TextFormField(
                              style: const TextStyle(fontSize: 12),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "ユーザ名を入力",
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                              ),
                              // パスワードガ見えないようにする
                              controller: _usernameController,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("学部学科", style: TextStyle(fontSize: 12)),
                          ),
                          Container(
                            height: 33,
                            width: 300,
                            // color: Colors.white,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: DropdownButton<String>(
                                underline: Container(),
                                items: facultyList
                                    .map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem,
                                        style: const TextStyle(fontSize: 12)),
                                  );
                                }).toList(),
                                //ドロップダウンから選択されたら、isSelected_faculityが更新される
                                value: ref.watch(selectedItemProvider),
                                onChanged: (String? newValue) {
                                  ref
                                      .read(selectedItemProvider.notifier)
                                      .state = newValue!;
                                },
                                // value: isSelectedFaculty,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("学年", style: TextStyle(fontSize: 12)),
                          ),
                          Container(
                            height: 33,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: DropdownButton<String>(
                                underline: Container(),
                                items:
                                    gradeList.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem,
                                        style: const TextStyle(fontSize: 12)),
                                  );
                                }).toList(),
                                value: ref.watch(selectedGradeProvider),
                                onChanged: (String? newValue) {
                                  ref
                                      .read(selectedGradeProvider.notifier)
                                      .state = newValue!;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              //新規登録処理
                              if (_formKey.currentState!.validate()) {
                                ref
                                    .read(signUpViewModelProvider)
                                    .signUp(
                                        _mailAddressController.text,
                                        _passwordController.text,
                                        UserData(
                                          name: _usernameController.text,
                                          faculty: ref
                                              .read(
                                                  selectedItemProvider.notifier)
                                              .state,
                                          grade: ref
                                              .read(selectedGradeProvider
                                                  .notifier)
                                              .state,
                                        ))
                                    .then(
                                        (value) => successSignUpDialog(context))
                                    .catchError((e) =>
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(e.toString()))));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                            child: const Text(
                              "新規登録する",
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () {
                          //ログイン画面に飛ばす処理
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => const LoginPage()));
                        },
                        child: const Text(
                          "アカウントをお持ちの方はこちら",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
