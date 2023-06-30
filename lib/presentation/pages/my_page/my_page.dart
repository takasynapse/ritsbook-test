import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
// import 'package:projectritsbook_native/presentation/providers.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPage extends ConsumerWidget {
  MyPage({Key? key}) : super(key: key);
  final url = Uri.parse("https://twitter.com/ritsbook");
  final terms = Uri.parse("https://ritsbook.netlify.app/policy");
  final guide = Uri.parse("https://ritsbook.netlify.app/guide");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final auth = ref.watch(authStateChangesProvider);
    // final getUserData = ref.watch(getUserDataUseCaseProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('マイページ'),
        // backgroundColor: const Color(0xffff6b6b),
        elevation: 0,
      ),
      body: ListView(
        children: <Widget>[
          const Text(
            'プロフィール',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const Gap(20),
          // if (uid ==true)
          // Padding(
          //   padding: const EdgeInsets.only(right: 32, bottom: 10),
          //   child: Align(
          //     alignment: Alignment.centerRight,
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         foregroundColor: Colors.black,
          //         backgroundColor: const Color(0xffffcfcf),
          //         shape: const CircleBorder(),
          //       ),
          //       onPressed: () {
          //         FirebaseAuth.instance.authStateChanges().listen((User? user) {
          //           if (user != null) {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => EditProfilePage()),
          //             );
          //           } else {
          //             _showDialogCheckauth();
          //           }
          //         });
          //       },
          //       child: const Icon(Icons.edit_outlined),
          //     ),
          //   ),
          // ),
          // if (uid ==true)
          // Padding(
          //   padding: const EdgeInsets.only(
          //     right: 40.0,
          //     left: 36,
          //   ),
          //   child:
          //   Container(
          //     decoration: BoxDecoration(
          //       border: Border.all(color: const Color(0xffff6b6b)),
          //       borderRadius: BorderRadius.circular(20),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.only(
          //         top: 18.0,
          //         bottom: 18.0,
          //         left: 18.0,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         // mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Column(
          //             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //             children: const <Widget>[
          //               Text('ユーザー名',
          //                   style: TextStyle(
          //                     fontSize: 16,
          //                   )),
          //               Gap(10),
          //               Text('学部',
          //                   style: TextStyle(
          //                     fontSize: 16,
          //                   )),
          //               Gap(10),
          //               Text('学年',
          //                   style: TextStyle(
          //                     fontSize: 16,
          //                   )),
          //             ],
          //           ),
          //           const SizedBox(
          //             width: 50,
          //           ),
          //           Flexible(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(username),
          //                 const Gap(10),
          //                 Text(qualifity),
          //                 const Gap(10),
          //                 Text(grade),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             margin: const EdgeInsets.only(left: 80),
          //             padding: const EdgeInsets.only(
          //               top: 50,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // )
          // else
          // const SizedBox(
          //   height: 200,
          //   child: Center(child: Text('ログインしてください'))),
          Padding(
            padding: const EdgeInsets.only(
              top: 52,
            ),
            child: Column(
              children: [
                const Divider(
                  height: 1,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.check_box_outlined),
                    title: const Text('出品した商品・購入した商品'),
                    onTap: () {
                    },
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.question_mark),
                    title: const Text('RitsBookの使い方'),
                    onTap: () {
                      launchUrl(guide);
                    },
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.event_note_rounded),
                    title: const Text('利用規約'),
                    onTap: () {
                      launchUrl(terms);
                    },
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.chat),
                    title: const Text('Twitter'),
                    onTap: () async {
                      await launchUrl(url);
                    },
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                  child: ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('ログアウト'),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                  ),
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                )
                // if (uid ==true)
                // Padding(
                //   padding: const EdgeInsets.only(left: 20, top: 8, bottom: 8),
                //   child: ListTile(
                //     leading: const Icon(Icons.exit_to_app),
                //     title: const Text('退会する'),
                //     onTap: () async {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => WithdrawalPage()),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
