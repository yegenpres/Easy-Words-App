import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wordsapp/features/autentifications/firebase_controller.dart';
import 'package:wordsapp/features/http_client.dart';
import 'package:wordsapp/features/subscription/purchase_api.dart';
import 'package:wordsapp/features/user/user_controller.dart';

class ProfileState {
  static final provider = FutureProvider<ProfileState>((ref) async {
    final result = await NetworkClient.subscriptions.countFreeDays();
    final freeDays = result < 0 ? 0 : result;

    final expiredData = await PurchaseApi.expiredData();

    final isLogedIn = ref.watch(UserController.stateProvider).isLogedIn;

    return ProfileState(freeDays, expiredData, isLogedIn);
  });

  final int freeDays;
  final String expiredData;
  final bool isLogedIn;

  void singOut() {
    AuthenticationService().signOut();
  }

  ProfileState(this.freeDays, this.expiredData, this.isLogedIn);
}
