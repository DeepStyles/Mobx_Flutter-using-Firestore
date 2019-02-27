// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies

mixin _$Mobxfirestore on MobxfirestoreBase, Store {
  Computed<List<Fullname>> _$fullNamesFromFirestoreComputed;

  @override
  List<Fullname> get fullNamesFromFirestore =>
      (_$fullNamesFromFirestoreComputed ??=
              Computed<List<Fullname>>(() => super.fullNamesFromFirestore))
          .value;

  final _$fullNameAtom = Atom(name: 'MobxfirestoreBase.fullName');

  @override
  Fullname get fullName {
    _$fullNameAtom.reportObserved();
    return super.fullName;
  }

  @override
  set fullName(Fullname value) {
    mainContext.checkIfStateModificationsAreAllowed(_$fullNameAtom);
    super.fullName = value;
    _$fullNameAtom.reportChanged();
  }

  final _$fullNamesAtom = Atom(name: 'MobxfirestoreBase.fullNames');

  @override
  ObservableFuture<List<Fullname>> get fullNames {
    _$fullNamesAtom.reportObserved();
    return super.fullNames;
  }

  @override
  set fullNames(ObservableFuture<List<Fullname>> value) {
    mainContext.checkIfStateModificationsAreAllowed(_$fullNamesAtom);
    super.fullNames = value;
    _$fullNamesAtom.reportChanged();
  }

  final _$getFromFirestoreAsyncAction = AsyncAction('getFromFirestore');

  @override
  Future<bool> getFromFirestore() {
    return _$getFromFirestoreAsyncAction.run(() => super.getFromFirestore());
  }

  final _$delFromFirestoreAsyncAction = AsyncAction('delFromFirestore');

  @override
  Future<bool> delFromFirestore(Fullname fullname) {
    return _$delFromFirestoreAsyncAction
        .run(() => super.delFromFirestore(fullname));
  }

  final _$pushToFirestoreAsyncAction = AsyncAction('pushToFirestore');

  @override
  Future<bool> pushToFirestore(Fullname fullname) {
    return _$pushToFirestoreAsyncAction
        .run(() => super.pushToFirestore(fullname));
  }
}
