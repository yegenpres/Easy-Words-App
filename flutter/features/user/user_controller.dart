import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/architect/abstract/abstracts.dart';
import 'package:wordsapp/features/user/user_model.dart';

class UserController extends DataController<UserData> {
  void Function(String userId)? onSetUserID;

  static late StateNotifierProvider<UserController, UserData> stateProvider;
  UserController(
      {required super.provider, super.initialHandler, this.onSetUserID})
      : super(initialData: UserData());

  void set({String? id, String? email, bool? isSubscribed, bool? isLogedIn}) {
    final bool logedIn = state.id != null ? true : false;

    state = state.copyWith(
      id: id ?? state.id,
      email: email ?? state.email,
      isSubscribed: isSubscribed ?? state.isSubscribed,
      isLogedIn: isLogedIn ?? logedIn,
    );
    provider.save(state);

    if (id != null) {
      onSetUserID?.call(id);
    }
  }
}
