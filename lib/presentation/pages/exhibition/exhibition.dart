import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:projectritsbook_native/presentation/pages/exhibition/exhibition_body.dart';

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
        body: const ExhibitionPageBody());
  }
}
