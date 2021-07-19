import 'package:firebase_auth/firebase_auth.dart';

class AuthRespoce {
  final UserCredential? authCredential;
  final String? authErrorMessage;

  AuthRespoce(this.authCredential, this.authErrorMessage);
  AuthRespoce.matchedCredential(UserCredential credential)
      : authCredential = credential,
        authErrorMessage = null;
  AuthRespoce.authError(String error)
      : authCredential = null,
        authErrorMessage = error;
}
