import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/models/auth_respoce.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../constants.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthRepos {
  AuthRepos() {
    authInstance = FirebaseAuth.instance;
  }
  late FirebaseAuth authInstance;

  Future<AuthRespoce> logInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential? authCredential;
      authCredential = await authInstance.signInWithEmailAndPassword(
          email: email, password: password);
      return AuthRespoce.matchedCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      return AuthRespoce.authError(
          e.message ?? FirebaseErrorMessage.defaultMessage);
    }
  }

  Future<AuthRespoce> createNewUser(String email, String password) async {
    try {
      UserCredential _userCrecential = await authInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      return AuthRespoce.matchedCredential(_userCrecential);
    } on FirebaseException catch (error) {
      return AuthRespoce.authError(
          error.message ?? FirebaseErrorMessage.defaultMessage);
    }
  }

  Future<void> logout() => authInstance.signOut();

  User? getCurrentUser() {
    return authInstance.currentUser;
  }

  bool isEmailVarified(User user) => user.emailVerified;

  Future<void> sendEmailVerificationLink(User user) =>
      user.sendEmailVerification();

  Future<void> sendForgetPassEmail(email) =>
      authInstance.sendPasswordResetEmail(email: email);

  Future<AuthRespoce> signInWithGooglleAccount() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

      GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication?.idToken,
          accessToken: googleSignInAuthentication?.accessToken);

      return AuthRespoce.matchedCredential(
          await authInstance.signInWithCredential(credential));
    } on FirebaseException catch (error) {
      return AuthRespoce.authError(
          error.message ?? FirebaseErrorMessage.defaultMessage);
    }
  }

  Future<AuthRespoce> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult result = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      return AuthRespoce.matchedCredential(userCredential);
    } on FirebaseAuthException catch (error) {
      print('Facebook login error');
      return AuthRespoce.authError(
          error.message ?? FirebaseErrorMessage.defaultMessage);
    }
  }
}
