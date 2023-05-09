import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/architect/abstract/abstracts.dart';
import 'package:wordsapp/features/session/session.dart';

typedef InitialHandler = void Function(SessionData);

class SessionController extends DataController<SessionData> {
  static late StateNotifierProvider<SessionController, SessionData>
      stateProvider;
  SessionController({required super.provider, super.initialHandler})
      : super(initialData: SessionData()) {
    _checkTimeToGetWords();
  }

  void _checkTimeToGetWords() {
    final now = DateTime.now();

    if (state.theLastUpdate == null) {
      state = state.copyWith(timeToGetNewWords: true);
      return;
    }

    final theLastApdate = DateTime.parse(state.theLastUpdate!);
    final result = now.difference(theLastApdate).inDays;

    assert(result >= 0, 'update can not be in future');

    if (result > 0) state = state.copyWith(timeToGetNewWords: true);
  }

  void wordsRepeated() {
    state = state.copyWith(isRepeated: true);
  }
}
