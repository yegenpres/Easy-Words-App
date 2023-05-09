import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/architect/interfaces/interfaces.dart';

abstract class AppException implements Exception {
  String errMsg();
}

@immutable
abstract class DataClass<T> {}

abstract class DataController<T extends DataClass<T>> extends StateNotifier<T> {
  @protected
  final DataProvider<T> provider;

  @protected
  final void Function(T)? initialHandler;

  DataController({
    required T initialData,
    required this.provider,
    this.initialHandler,
  }) : super(initialData) {
    if (provider is DataProviderAsync) {
      final providerAsync = provider as DataProviderAsync<T>;
      providerAsync.fetch().then((value) {
        state = value;
        if (initialHandler != null) {
          initialHandler!(state);
        }
      });
    } else {
      state = provider.fetch() as T;
      if (initialHandler != null) {
        initialHandler!(state);
      }
    }
  }
}
