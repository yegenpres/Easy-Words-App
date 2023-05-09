import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordsapp/_widgets/utils.dart';
import 'package:wordsapp/generated/l10n.dart';
import 'package:wordsapp/policy.dart';
import 'package:wordsapp/terms_of_service.dart';

class PolicyasAndTerms extends StatelessWidget {
  const PolicyasAndTerms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Text(S.of(context).privacy,
                style: const TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue)),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => adaptivePage(
                    child: PolicyPage(
                        documentText: policy, title: S.of(context).privacy),
                  ),
                ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(""),
          ),
          GestureDetector(
            child: Text(S.of(context).terms,
                style: const TextStyle(
                    decoration: TextDecoration.underline, color: Colors.blue)),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => adaptivePage(
                    child: PolicyPage(
                      documentText: termsOfUse,
                      title: S.of(context).terms,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PolicyPage extends StatelessWidget {
  const PolicyPage({Key? key, required this.documentText, required this.title})
      : super(key: key);
  final String title;
  final String documentText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        if (Platform.isIOS || Platform.isMacOS)
          CupertinoNavigationBar(
            middle: Text(title),
          ),
        if (Platform.isAndroid || Platform.isWindows)
          AppBar(
            title: Text(title),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(documentText),
        )
      ],
    ));
  }
}
