import 'dart:convert';
import 'dart:developer';
import 'dart:math' hide log;

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:wordsapp/view_model/debuging_features/logger.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      lv6(e.message.toString());
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential?> signInWithApple() async {
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      return await _auth.signInWithCredential(oauthCredential);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<UserCredential?> signInWithEmail(
      {required String email, required String password}) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<UserCredential?> logInWithEmail(
      {required String email, required String password}) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<bool> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
