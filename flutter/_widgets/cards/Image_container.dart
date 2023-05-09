import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wordsapp/architect/interfaces/interfaces.dart';

class ImageContainer extends StatefulWidget {
  final double opacity, scale;
  final Widget? child;
  final ImagedWordable word;
  const ImageContainer({
    super.key,
    this.child,
    required this.word,
    this.opacity = 1,
    this.scale = 1,
  });

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  Uint8List? imageData;

  @override
  void initState() {
    widget.word.fetchImage().then((bytes) => setState(() {
          imageData = bytes;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.word.isImaged) return widget.child ?? const Center();
    if (imageData == null) {
      return Stack(
        children: [
          const Positioned.fill(
              child: Padding(
            padding: EdgeInsets.all(80.0),
            child: CircularProgressIndicator.adaptive(),
          )),
          widget.child ?? const Center(),
        ],
      );
    } else {
      return Transform.scale(
        scale: widget.scale,
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.memory(imageData!).image,
              fit: BoxFit.fill,
              opacity: widget.opacity,
            ),
          ),
          child: widget.child ?? const Center(),
        ),
      );
    }
  }
}
