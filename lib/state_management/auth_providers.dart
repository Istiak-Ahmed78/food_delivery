import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery/constants.dart';
import 'package:food_delivery/models/auth_respoce.dart';
import 'package:food_delivery/utils/repos/auth_repo.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepos authRepos;
  AuthProvider({required this.authRepos});

  User? currentUser;
  String firebaseLocalErrorMessage = '';
  bool isLoadingLocal = false;

  User? get currentuser => currentUser;
  String get firebaseErrorMessgase => firebaseLocalErrorMessage;
  bool get isLoading => isLoadingLocal;

  Future<bool> logInwithEmailAndPassword(String email, String password) async {
    isLoadingLocal = true;
    notifyListeners();
    AuthRespoce authRespoce =
        await authRepos.logInWithEmailAndPassword(email, password);
    if (authRespoce.authCredential != null) {
      currentUser = authRespoce.authCredential!.user;
      isLoadingLocal = false;
      notifyListeners();
      return true;
    } else {
      firebaseLocalErrorMessage = authRespoce.authErrorMessage ?? '';
      isLoadingLocal = false;
      notifyListeners();
      return false;
    }
  }

  bool isLoggedIn() =>
      authRepos.getCurrentUser() != null &&
      authRepos.getCurrentUser()!.emailVerified;
  bool isEmailVarified(User user) => authRepos.isEmailVarified(user);

  Future<void> sendVerificationEmail(User user) =>
      authRepos.sendEmailVerificationLink(user);

  Future<bool> sendForgetPasswordMail(email) async {
    try {
      await authRepos.sendForgetPassEmail(email);
      return true;
    } on FirebaseException catch (e) {
      firebaseLocalErrorMessage =
          e.message ?? FirebaseErrorMessage.defaultMessage;
      notifyListeners();
      return false;
    }
  }

  Future<bool> createUser(String email, String password) async {
    isLoadingLocal = true;
    notifyListeners();
    AuthRespoce authRespoce = await authRepos.createNewUser(email, password);
    if (authRespoce.authCredential != null) {
      currentUser = authRespoce.authCredential!.user;
      isLoadingLocal = false;
      notifyListeners();
      return true;
    } else {
      firebaseLocalErrorMessage = authRespoce.authErrorMessage ?? '';
      isLoadingLocal = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> signInWithGoogle() async {
    isLoadingLocal = true;
    notifyListeners();
    AuthRespoce _authRespoce = await authRepos.signInWithGooglleAccount();
    if (_authRespoce.authCredential != null) {
      currentUser = _authRespoce.authCredential!.user;
      isLoadingLocal = false;
      notifyListeners();
    } else {
      firebaseLocalErrorMessage = _authRespoce.authErrorMessage ?? '';
      isLoadingLocal = false;
      notifyListeners();
    }
  }

  Future<void> singnInWithFacebook() async {
    isLoadingLocal = true;
    notifyListeners();
    AuthRespoce _authRespoce = await authRepos.signInWithFacebook();
    if (_authRespoce.authCredential != null) {
      currentUser = _authRespoce.authCredential!.user;
      isLoadingLocal = false;
      notifyListeners();
    } else {
      firebaseLocalErrorMessage = _authRespoce.authErrorMessage ?? '';
      isLoadingLocal = false;
      notifyListeners();
    }
  }

  void logOut() async {
    await authRepos.logout();
    currentUser = null;
    notifyListeners();
  }
}
