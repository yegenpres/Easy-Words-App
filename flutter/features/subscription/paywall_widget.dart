import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:sizer/sizer.dart';
import 'package:wordsapp/extensions.dart';
import 'package:wordsapp/generated/l10n.dart';
import 'package:wordsapp/view/privacy_policy.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';
import 'package:wordsapp/view_model/subscription_state.dart';

class PaywallWidget extends StatefulWidget {
  final String title, description;
  final List<Package> packages;
  final ValueChanged<Package> onClickedPackage;

  const PaywallWidget({
    Key? key,
    this.title = '',
    this.description = '',
    required this.packages,
    required this.onClickedPackage,
  }) : super(key: key);

  @override
  State<PaywallWidget> createState() => _PaywallWidgetState();
}

class _PaywallWidgetState extends State<PaywallWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(widget.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 15)),
            const FeaturesTable(),
            BuildPackages(
              onClickedPackage: widget.onClickedPackage,
              packages: widget.packages,
            ),
            const RestoreButton(),
            const PolicyasAndTerms()
          ]),
        ));
  }
}

class RestoreButton extends ConsumerWidget {
  const RestoreButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: GestureDetector(
        child: Text(S.of(context).restorePurchases,
            style: const TextStyle(
                decoration: TextDecoration.underline, color: Colors.blue)),
        onTap: () {
          ref.read(restorePurchase);
        },
      ),
    );
  }
}

class FeaturesTable extends StatelessWidget {
  const FeaturesTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Feature(
          description: S.of(context).future1,
        ),
        Feature(
          description: S.of(context).future2,
        ),
        Feature(
          description: S.of(context).future3,
        ),
        Feature(
          description: S.of(context).future4,
        ),
        Feature(
          description: S.of(context).future5,
        ),
      ],
    );
  }
}

class Feature extends StatelessWidget {
  const Feature({Key? key, required this.description}) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.checkmark_alt_circle,
            color: Colors.green,
          ),
          SizedBox(
            width: 6.w,
          ),
          Flexible(
            child: Text(
              description,
              style: TextStyle(color: context.appColors.text, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildPackages extends StatelessWidget {
  final List<Package> packages;
  final ValueChanged<Package> onClickedPackage;

  const BuildPackages(
      {Key? key, required this.packages, required this.onClickedPackage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: packages.length,
      itemBuilder: (context, index) {
        final package = packages[index];

        return BuildPackage(
          package,
          onClickedPackage,
        );
      },
    );
  }
}

class BuildPackage extends StatelessWidget {
  final ValueChanged<Package> onClickedPackage;

  final Package package;

  const BuildPackage(this.package, this.onClickedPackage, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    lv6("package discription");
    lv6(package.toString());
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Theme(
        data: ThemeData.light(),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          title: Text(
            S.of(context).purchaseTitle,
            style: const TextStyle(fontSize: 18),
          ),
          subtitle: Text(S.of(context).purchaseDescription),
          trailing: Column(
            children: [
              const Text(
                "11.89\$",
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.redAccent,
                  decorationThickness: 2.0,
                  fontSize: 18,
                ),
              ),
              Text(
                package.storeProduct.priceString,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          onTap: () => onClickedPackage(package),
        ),
      ),
    );
  }
}
