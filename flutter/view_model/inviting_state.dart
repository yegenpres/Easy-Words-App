import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wordsapp/config.dart';
import 'package:wordsapp/features/deep_link_service/firebase_dynamic_link_service.dart';
import 'package:wordsapp/features/http_client.dart';
import 'package:wordsapp/features/subscription/purchase_api.dart';
import 'package:wordsapp/features/user/user_controller.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';

part 'inviting_state.freezed.dart';

@freezed
class InvitingState with _$InvitingState {
  const factory InvitingState.received() = _InvitingStateReceived;

  const factory InvitingState.empty() = _InvitingStateEmpty;
  const factory InvitingState.loaded(String link) = _InvitingStateLoaded;
  const factory InvitingState.confirmed() = _InvitingStateConfirmed;
  const factory InvitingState.reject() = _InvitingStateReject;
}

class InvitingFriendState {
  static final makeInviting = FutureProvider<InvitingState>((ref) async {
    String token = '';
    try {
      final request = await NetworkClient.dio.get(ApiHTTP.getInvitingToken);
      token = request.data.toString();
    } catch (e) {
      lv6(e.toString());
      return const InvitingState.empty();
    } finally {}

    if (token == '') return const InvitingState.empty();
    return InvitingState.loaded(
      await FirebaseDynamicLincService.createDynamicLink(token),
    );
  });

  static final receiveInviting = FutureProvider.family<InvitingState, String>(
    (ref, token) async {
      try {
        final request =
            await NetworkClient.dio.get(ApiHTTP.getConfirmInviting(token));
        bool confirm = request.data as bool;

        if (confirm) {
          final isAccessed = await PurchaseApi.hasAccess();
          ref
              .watch(UserController.stateProvider.notifier)
              .set(isSubscribed: isAccessed);

          return const InvitingState.confirmed();
        } else {
          return const InvitingState.reject();
        }
      } catch (e) {
        return const InvitingState.received();
      }
    },
  );
}
