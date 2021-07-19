import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
    AuthRespoce authRespoce =
        await authRepos.logInWithEmailAndPassword(email, password);
    notifyListeners();
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

  Future<bool> createUser(String email, String password) async {
    isLoadingLocal = true;
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

  Future<bool> signInWithGoogle() async {
    isLoadingLocal = true;
    AuthRespoce _authRespoce = await authRepos.signInWithGooglleAccount();
    if (_authRespoce.authCredential != null) {
      currentUser = _authRespoce.authCredential!.user;
      isLoadingLocal = false;
      notifyListeners();
      return true;
    } else {
      firebaseLocalErrorMessage = _authRespoce.authErrorMessage ?? '';
      isLoadingLocal = false;
      notifyListeners();
      return false;
    }
  }

  void logOut() async {
    isLoadingLocal = true;
    await authRepos.logout();
    currentUser = null;
    isLoadingLocal = false;
    notifyListeners();
  }
}
