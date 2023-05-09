import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:l/l.dart';
import 'package:wordsapp/features/subscription/purchase_api.dart';
import 'package:wordsapp/features/user/user_controller.dart';

part 'subscription_state.freezed.dart';

@freezed
class SubscriptioState with _$SubscriptioState {
  const factory SubscriptioState.subscribed() = Subscribed;
  const factory SubscriptioState.noSubscribed() = NoSubscribed;
  factory SubscriptioState.error(Object e) = ErrorSub;
}


final subscribeAytoAction = FutureProvider<SubscriptioState>(((ref) async {
  bool isSubscribed = await PurchaseApi.isSubscribed();
  if (isSubscribed) {
    return const SubscriptioState.subscribed();
  } else {
    return const SubscriptioState.noSubscribed();
  }
}));

final restorePurchase = FutureProvider<SubscriptioState>(((ref) async {
  bool isSubscribed = ref.watch(UserController.stateProvider).isSubscribed;

  if (isSubscribed) {
    return const SubscriptioState.subscribed();
  }

  String? userId = ref.read(UserController.stateProvider).id;
  final isRestored = await PurchaseApi.restorePurchase(userId ?? "");

  if (isRestored) {
    ref
        .watch(UserController.stateProvider.notifier)
        .set(isSubscribed: isRestored);
    return const SubscriptioState.subscribed();
  }
  return const SubscriptioState.noSubscribed();
}));

testSudscribe(WidgetRef ref) {
  if (!kDebugMode) return;
  final setSebscribed = ref.read(UserController.stateProvider.notifier).set;
  setSebscribed(isSubscribed: true);
}
