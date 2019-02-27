import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';

part 'login.g.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

class Login = LoginBase with _$Login;

abstract class LoginBase implements Store {
  LoginBase();

  @observable
  bool logIn = false;

  @observable
  bool logOut = false;

  @observable
  ObservableFuture<bool> loginStatus = ObservableFuture<bool>.value(false);

  @action
  void changeLoginStatus(dynamic status) {
    loginStatus = status;
  }

  @computed
  bool get updatedLoginStatus => loginStatus.value;

  @action
  Future<bool> googleLogin() async {
    GoogleSignInAccount gUser = await getGoogleuser();
    GoogleSignInAuthentication googauth = await gUser.authentication;
    FirebaseUser user;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googauth.idToken,
      accessToken: googauth.accessToken,
    );
    user = await _auth.signInWithCredential(credential);

    if (user.uid != null) {
      print('googlogin userName: ${user.uid}');
      loginStatus = ObservableFuture.value(true);
    } else {
      print('googlogin else called!!!');
      loginStatus = ObservableFuture.value(false);
    }

    return Future.value(true);
  }

  @action
  Future<bool> logoutAccount() async {
    _googleSignIn.signOut();
    _auth.signOut();
    print('Google logged out');
    loginStatus = ObservableFuture.value(false);
    return await Future.value(true);
  }

  Future getGoogleuser() async {
    GoogleSignInAccount googleUser = _googleSignIn.currentUser;
    if (googleUser == null) {
      googleUser = await _googleSignIn.signInSilently();
    }
    if (googleUser == null) {
      googleUser = await _googleSignIn.signIn();
    }

    return googleUser;
  }
}
