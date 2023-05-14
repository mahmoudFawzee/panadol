// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FirebaseAuthApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final facebookAuth = FacebookAuth.instance;


  bool get isUser {
    User? user = _auth.currentUser;
    if (user != null) {
      return true;
    }
    return false;
  }

  String? get userEmail {
    User? user = _auth.currentUser;
    return user!.email;
  }

  Future<bool> signInWithFacebook() async {
    print('start');
    final LoginResult result = await facebookAuth.login(permissions: const ['email', 'public_profile'],);

    final accessToken = result.accessToken!.token;
    print('access token : $accessToken');

     OAuthCredential facebookCredential = FacebookAuthProvider.credential(accessToken);

    UserCredential cred = await singInWithCred(facebookCredential);
    
    if (cred.user != null) return true;
    return false;
  }

  Future<bool> signInGoogle() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) return false;
    final googleAuth = await googleUser.authentication;
    //await UserDataPreferences.setUserId(googleUser.email);

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential cred = await singInWithCred(credential);
    if (cred.user != null) return true;
    return false;
  }

  Future<UserCredential> singInWithCred(AuthCredential credential) async {
    return await _auth.signInWithCredential(credential);
  }

  String? _verificationId;
  int? _resendToken;
  Future<bool> sendOtpCode({
    required String phoneNumber,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      codeSent: (
        String verificationId,
        int? resendToken,
      ) {
        _verificationId = verificationId;
        _resendToken = resendToken;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      timeout: const Duration(
        seconds: 30,
      ),
      forceResendingToken: _resendToken,
    );
    return true;
  }

  Future<bool> verifyOTP({required String otp,}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: otp,
    );
    UserCredential userCredential = await singInWithCred(credential);
    if (userCredential.user != null) return true;
    return false;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
