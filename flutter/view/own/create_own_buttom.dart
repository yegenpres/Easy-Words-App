import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordsapp/view/own/common_words.dart';
import 'package:wordsapp/view/own/creating_form.dart';
import 'package:wordsapp/view/own/draggable_scrollable_words_list.dart';

class CreateOwnButton extends StatelessWidget {
  static Widget _platformButton() {
    if (Platform.isIOS) {
      return const Icon(
        CupertinoIcons.add,
        size: 30,
      );
    }
    return const Icon(Icons.add);
  }

  const CreateOwnButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: CupertinoButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return const DraggableScrollableWordsList(
                  children: [
                    CommonWords(),
                    CreatingForm(),
                  ],
                );
              });
        },
        child: _platformButton(),
      ),
    );
  }
}
