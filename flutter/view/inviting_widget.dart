import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wordsapp/view_model/inviting_state.dart';

class InvitingWidget extends ConsumerStatefulWidget {
  const InvitingWidget({super.key});

  @override
  InvitingWidgetState createState() => InvitingWidgetState();
}

class InvitingWidgetState extends ConsumerState<InvitingWidget> {
  String link = '';
  bool isLinkErr = false;

  @override
  Widget build(BuildContext context) {
    ref.watch(InvitingFriendState.makeInviting).when(
          loading: () {
            isLinkErr = true;
          },
          error: (e, st) {
            isLinkErr = true;
          },
          data: (state) => state.maybeWhen(
            orElse: () {
              isLinkErr = true;
            },
            loaded: (link) {
              isLinkErr = false;
              this.link = link;
            },
          ),
        );
    return Column(
      children: [
        const Text(
          "Invite your friend and get 7 days free!",
          style: TextStyle(color: Colors.green),
        ),
        CupertinoButton(
          onPressed: () {
            Share.share(link);
          },
          child: const Text("Invite"),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Visibility(
            visible: isLinkErr,
            child: const Text(
              "No connection with server check Your internet connection",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
