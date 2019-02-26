import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
//import 'package:shared_preferences/shared_preferences.dart';

part 'login.g.dart';

//Future<SharedPreferences> _sharedPref = SharedPreferences.getInstance();
final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

class Login = LoginBase with _$Login;

abstract class LoginBase implements Store {
  LoginBase() {
    //   final disposeLogin = when((_) => logIn == true, () => googleLogin());
    // final disposeLogout = when((_) => logOut == true, () => logoutAccount());
  }

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

  /* Future googleLogin() async{

  final  GoogleSignInAccount gUser = await getGoogleuser();
  final  GoogleSignInAuthentication creds = await gUser.authentication;
  final SharedPreferences prefs = await _sharedPref;
    //var userName;
    FirebaseUser user;

     user = await _auth.signInWithGoogle(
      idToken: creds.idToken,
      accessToken: creds.accessToken,
    );


     

  }
 */

/*   @action
  Future<Null> run<Null>(Future<dynamic>googleLogin())async{
    try {
      return await 
    } catch (e) {
    }

  }
 */

  // final temp = Action(name)

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

  /* void logoutAccount() async {
    //  final SharedPreferences prefs = await _sharedPref;

    _googleSignIn.signOut();
    _auth.signOut();
    print('Google logged out');
    // _loginController.drain();

    //prefs.setString('userName', '');
  } */
}
