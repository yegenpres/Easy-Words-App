import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WordsTemplatesSelector extends StatelessWidget {
  final void Function() backButton;
  final void Function() clearButton;
  final void Function() nextButton;

  const WordsTemplatesSelector(
      {super.key,
      required this.backButton,
      required this.clearButton,
      required this.nextButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: SizedBox(),
          ),
          Button(
              icons: const [CupertinoIcons.chevron_left], handler: backButton),
          Button(icons: const [CupertinoIcons.clear], handler: clearButton),
          Button(
              icons: const [CupertinoIcons.chevron_right], handler: nextButton),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final bool isCustom;
  final List<Widget>? child;
  final List<IconData> icons;
  final void Function() handler;
  const Button({super.key, required this.icons, required this.handler})
      : isCustom = false,
        child = null;
  const Button.custom({super.key, required this.child, required this.handler})
      : isCustom = true,
        icons = const [];

  @override
  Widget build(BuildContext context) {
    if (isCustom) {
      if (Platform.isIOS) {
        return _ButtonCupertino.custom(
          handler: handler,
          child: child,
        );
      }
      return _ButtonMaterial.custom(
        handler: handler,
        child: child,
      );
    }

    if (Platform.isIOS) return _ButtonCupertino(icons: icons, handler: handler);
    return _ButtonMaterial(icons: icons, handler: handler);
  }
}

class _ButtonCupertino extends StatelessWidget {
  final bool isCustom;
  final List<Widget>? child;
  final List<IconData> icons;
  final void Function() handler;
  const _ButtonCupertino({required this.icons, required this.handler})
      : child = null,
        isCustom = false;

  const _ButtonCupertino.custom({required this.child, required this.handler})
      : icons = const [],
        isCustom = true;

  List<Widget> _buildChild() => child!;
  List<Widget> _buildIcons(BuildContext context) => icons
      .map((icon) =>
          Icon(icon, size: 30, color: CupertinoTheme.of(context).primaryColor))
      .toList();

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: handler,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: isCustom ? _buildChild() : _buildIcons(context),
      ),
    );
  }
}

class _ButtonMaterial extends StatelessWidget {
  final bool isCustom;
  final List<Widget>? child;
  final List<IconData> icons;
  final void Function() handler;
  const _ButtonMaterial({required this.icons, required this.handler})
      : child = null,
        isCustom = false;

  const _ButtonMaterial.custom({required this.child, required this.handler})
      : icons = const [],
        isCustom = true;

  List<Widget> _buildChild() => child!;
  List<Widget> _buildIcons(BuildContext context) => icons
      .map((icon) =>
          Icon(icon, size: 30, color: CupertinoTheme.of(context).primaryColor))
      .toList();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handler,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: isCustom ? _buildChild() : _buildIcons(context),
      ),
    );
  }
}
