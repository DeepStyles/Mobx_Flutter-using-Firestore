// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies

mixin _$Login on LoginBase, Store {
  Computed<bool> _$updatedLoginStatusComputed;

  @override
  bool get updatedLoginStatus => (_$updatedLoginStatusComputed ??=
          Computed<bool>(() => super.updatedLoginStatus))
      .value;

  final _$logInAtom = Atom(name: 'LoginBase.logIn');

  @override
  bool get logIn {
    _$logInAtom.reportObserved();
    return super.logIn;
  }

  @override
  set logIn(bool value) {
    mainContext.checkIfStateModificationsAreAllowed(_$logInAtom);
    super.logIn = value;
    _$logInAtom.reportChanged();
  }

  final _$logOutAtom = Atom(name: 'LoginBase.logOut');

  @override
  bool get logOut {
    _$logOutAtom.reportObserved();
    return super.logOut;
  }

  @override
  set logOut(bool value) {
    mainContext.checkIfStateModificationsAreAllowed(_$logOutAtom);
    super.logOut = value;
    _$logOutAtom.reportChanged();
  }

  final _$loginStatusAtom = Atom(name: 'LoginBase.loginStatus');

  @override
  ObservableFuture<bool> get loginStatus {
    _$loginStatusAtom.reportObserved();
    return super.loginStatus;
  }

  @override
  set loginStatus(ObservableFuture<bool> value) {
    mainContext.checkIfStateModificationsAreAllowed(_$loginStatusAtom);
    super.loginStatus = value;
    _$loginStatusAtom.reportChanged();
  }

  final _$googleLoginAsyncAction = AsyncAction('googleLogin');

  @override
  Future<bool> googleLogin() {
    return _$googleLoginAsyncAction.run(() => super.googleLogin());
  }

  final _$logoutAccountAsyncAction = AsyncAction('logoutAccount');

  @override
  Future<bool> logoutAccount() {
    return _$logoutAccountAsyncAction.run(() => super.logoutAccount());
  }

  final _$LoginBaseActionController = ActionController(name: 'LoginBase');

  @override
  void changeLoginStatus(dynamic status) {
    final _$actionInfo = _$LoginBaseActionController.startAction();
    try {
      return super.changeLoginStatus(status);
    } finally {
      _$LoginBaseActionController.endAction(_$actionInfo);
    }
  }
}
