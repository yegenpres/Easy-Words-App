import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordsapp/extensions.dart';

void invitingCongretulationView(BuildContext context) {
  platformSelector(
    material: () {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Free period access!"),
              content:
                  const Text("Congratulations, You have received 7 days FREE!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("ok"),
                ),
              ],
            );
          });
    },
    cupertino: () {
      showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text("Free period access!"),
              content:
                  const Text("Congratulations, You have received 7 days FREE!"),
              actions: [
                CupertinoDialogAction(
                  child: const Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    },
  )();
}
