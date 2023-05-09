import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wordsapp/extensions.dart';
import 'package:wordsapp/features/create_own_word/empty_word.dart';
import 'package:wordsapp/features/word/word.dart';
import 'package:wordsapp/generated/l10n.dart';
import 'package:wordsapp/view/own/words_tamplates_selector.dart';

class TextFields extends StatefulWidget {
  final EmptyWord? word;
  final void Function(Word) onSave;

  const TextFields({super.key, this.word, required this.onSave});

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> with _TextControllers {
  Word _saveWord() {
    var now = DateTime.now().toString();
    Word newWord = Word(
        wordID: widget.word?.wordID ?? now,
        english: english,
        ruTranslate: translate,
        engTranscription: transcription,
        assotiation: association,
        ruTranscription: translateTranscription,
        isImaged: false);

    return newWord;
  }

  bool isEmpty() {
    if (english.isEmpty || translate.isEmpty || association.isEmpty)
      return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _Field(
              pacehollder: S.of(context).word,
              initValue: widget.word?.english,
              onSave: (english) {
                this.english = english ?? "";
              },
            ),
            _Field(
              pacehollder: S.of(context).translate,
              initValue: widget.word?.ruTranslate,
              onSave: (translate) {
                this.translate = translate ?? "";
              },
            ),
            _Field(
              pacehollder: S.of(context).Transcription,
              initValue: widget.word?.engTranscription,
              onSave: (transcription) {
                this.transcription = transcription ?? "";
              },
            ),
            _Field(
              pacehollder: S.of(context).Translate_Transcription,
              initValue: widget.word?.ruTranscription,
              onSave: (translateTr) {
                translateTranscription = translateTr ?? "";
              },
            ),
            _Field(
              pacehollder: S.of(context).AssociationText,
              maxLines: 5,
              onSave: (association) {
                this.association = association ?? "";
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Button(
                icons: const [CupertinoIcons.checkmark_alt],
                handler: () {
                  _formKey.currentState?.save();
                  if (isEmpty()) return;

                  widget.onSave(_saveWord());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

mixin _TextControllers on State<TextFields> {
  @override
  void didUpdateWidget(covariant TextFields oldWidget) {
    english = widget.word?.english ?? "";
    translate = widget.word?.ruTranslate ?? "";
    transcription = widget.word?.ruTranscription ?? "";
    translateTranscription = widget.word?.ruTranscription ?? "";
    super.didUpdateWidget(oldWidget);
  }

  final _formKey = GlobalKey<FormState>();

  String english = "";
  String translate = "";
  String transcription = "";
  String translateTranscription = "";
  String association = "";
}

class _Field extends StatelessWidget {
  final void Function(String?) onSave;
  final String? pacehollder;
  final String? initValue;

  final int maxLines;

  const _Field({
    this.maxLines = 1,
    Key? key,
    this.pacehollder,
    required this.onSave,
    this.initValue,
  }) : super(key: key);

  UnderlineInputBorder myfocusborder() {
    return const UnderlineInputBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.black,
          width: 0,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(Random.secure().nextDouble().toString()),
      textInputAction: TextInputAction.next,
      initialValue: initValue,
      decoration: InputDecoration(
        hintStyle: TextStyle(fontSize: 17, color: context.appColors.hinText),
        hintText: pacehollder,
        border: myfocusborder(),
        enabledBorder: myfocusborder(),
        focusedBorder: myfocusborder(),
        contentPadding: const EdgeInsets.fromLTRB(20, 8, 8, 8),
      ),
      style: TextStyle(color: context.appColors.text),
      maxLines: maxLines,
      onSaved: onSave,
    );
  }
}
