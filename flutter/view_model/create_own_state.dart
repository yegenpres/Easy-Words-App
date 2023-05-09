import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordsapp/features/create_own_word/controller_own_words.dart';
import 'package:wordsapp/features/create_own_word/created_words/controller_created_words.dart';
import 'package:wordsapp/features/create_own_word/empty_word.dart';
import 'package:wordsapp/features/create_own_word/word_parts_enum.dart';
import 'package:wordsapp/features/word/word.dart';

part 'create_own_state.freezed.dart';

@freezed
class CommonWordsState with _$CommonWordsState {
  const factory CommonWordsState.successData(Set<String> data) = SuccessData;
  const factory CommonWordsState.error() = Error;
  const factory CommonWordsState.empty() = Empty;
  const factory CommonWordsState.loading() = Loading;
  const factory CommonWordsState.initialData() = InitialData;
}

@freezed
class CreateOwnWordsState with _$CreateOwnWordsState {
  const factory CreateOwnWordsState.templatesForCreate(Set<EmptyWord> words) =
      TemplatesForCreateData;
  const factory CreateOwnWordsState.templatesForCreateLoading() =
      TemplatesForCreateLoading;
  const factory CreateOwnWordsState.errorTemplates(Error err) = ErrorOwnWOrds;
  const factory CreateOwnWordsState.empty() = EmptyOwnWords;
  const factory CreateOwnWordsState.wordCreated() = WordCreated;
  const factory CreateOwnWordsState.wordCreatedError() = WordCreatedError;
}

@freezed
class CreatedWordStory with _$CreatedWordStory {
  const factory CreatedWordStory.successData(Set<Word> words) =
      CreatedWordStorySuccessData;
  const factory CreatedWordStory.error() = CreatedWordStoryError;
  const factory CreatedWordStory.empty() = CreatedWordStoryEmpty;
  const factory CreatedWordStory.loading() = CreatedWordStoryLoading;
  const factory CreatedWordStory.initialData() = CreatedWordStoryInitialData;
}

class CreateOwnViewModel {
  static final emptyWords = Provider<CreateOwnWordsState>((ref) {
    final words = ref.watch(OwnWordsController.stateProvider).emptyWords;
    if (words.isEmpty) {
      return const CreateOwnWordsState.empty();
    } else {
      return CreateOwnWordsState.templatesForCreate(words);
    }
  });

  static final commonWords = Provider<CommonWordsState>(
    ((ref) {
      final words = ref.watch(OwnWordsController.stateProvider).wordsParts;

      if (words.first == WordParts.initialData.name) {
        return const CommonWordsState.initialData();
      } else if (words.first == WordParts.loadingData.name) {
        return const CommonWordsState.loading();
      } else if (words.isEmpty) {
        return const CommonWordsState.empty();
      } else {
        return CommonWordsState.successData(words);
      }
    }),
  );

  static final userActionCreate = Provider<void Function(Word)>(
    ((
      ref,
    ) {
      return (Word word) {
        ref.watch(ControllerCreatedWords.stateProvider.notifier).addWord(word);
        ref
            .watch(OwnWordsController.stateProvider.notifier)
            .remove(word.wordID);
      };
    }),
  );

  static final createdWords = Provider<CreatedWordStory>(
    ((ref) {
      final words = ref.watch(ControllerCreatedWords.stateProvider).words;

      if (words.isNotEmpty) return CreatedWordStory.successData(words);
      return const CreatedWordStory.empty();
    }),
  );
}
