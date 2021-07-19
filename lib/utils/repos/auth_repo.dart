import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/models/auth_respoce.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../constants.dart';

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
}
