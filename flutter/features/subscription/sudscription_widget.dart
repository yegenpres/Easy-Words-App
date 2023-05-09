import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:wordsapp/features/subscription/paywall_widget.dart';
import 'package:wordsapp/features/subscription/purchase_api.dart';
import 'package:wordsapp/generated/l10n.dart';

class SubscriptionWidget extends ConsumerStatefulWidget {
  final void Function(bool isSudscribed) onSubscribeCallback;
  const SubscriptionWidget({Key? key, required this.onSubscribeCallback})
      : super(key: key);

  @override
  ConsumerState<SubscriptionWidget> createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends ConsumerState<SubscriptionWidget> {
  List<Package> packages = [];
  bool _isLoading = false;

  @override
  void initState() {
    PurchaseApi.fetchSubscvription(context).then((value) {
      if (mounted) {
        setState(() {
          packages = value;
        });
      }
    });
    if (mounted) PurchaseApi.fetchSubscvription(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (packages.isNotEmpty)
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  if (Platform.isIOS && _isLoading)
                    const CupertinoActivityIndicator(),
                  if (!Platform.isIOS && _isLoading)
                    const CircularProgressIndicator(),
                  PaywallWidget(
                      packages: packages,
                      title: S.of(context).upgradePlane,
                      description: S.of(context).description,
                      onClickedPackage: (package) async {
                        setState(() {
                          _isLoading = true;
                        });

                        final subscribed =
                            await PurchaseApi.purchasePackage(package);
                        setState(() {
                          _isLoading = false;
                        });

                        widget.onSubscribeCallback(subscribed);
                      }),
                ],
              )
          ],
        ),
      ),
    );
  }
}
