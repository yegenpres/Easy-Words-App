import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordsapp/architect/abstract/abstracts.dart';

part 'user_model.freezed.dart';

@freezed
class UserData extends DataClass<UserData> with _$UserData {
  factory UserData({
    String? id,
    String? email,
    @Default(false) isSubscribed,
    @Default(false) isLogedIn,
  }) = _UserData;
}
