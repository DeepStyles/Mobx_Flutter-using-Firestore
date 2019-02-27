import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './fullnamemodel.dart';

part 'firestore.g.dart';

final Firestore _firestore = Firestore.instance;

class Mobxfirestore = MobxfirestoreBase with _$Mobxfirestore;

abstract class MobxfirestoreBase implements Store {
  MobxfirestoreBase();

  @observable
  Fullname fullName;

  @observable
  ObservableFuture<List<Fullname>> fullNames =
      ObservableFuture<List<Fullname>>.value([]);

  @computed
  List<Fullname> get fullNamesFromFirestore => fullNames.value;

  @action
  Future<bool> getFromFirestore() async {
    List<Fullname> fullnames = List();
    var query = _firestore.collection('FullNames').getDocuments();
    await query.then((snap) {
      print('snap length: ${snap.documents.length}');

      if (snap.documents.length > 0) {
        for (var doc in snap.documents) {
          fullnames.add(Fullname.fromfirestoresnapshot(doc));
          print('fullname docID: ${doc.documentID}');
        }

        print('fullnames length: ${fullnames.length}');

        fullNames = ObservableFuture<List<Fullname>>.value(fullnames);
      }
    });

    return Future.value(true);
  }

  @action
  Future<bool> delFromFirestore(Fullname fullname) async {
    if (fullname != null) {
      _firestore.collection('FullNames').document(fullname.documentID).delete();
    }

    return Future.value(true);
  }

  @action
  Future<bool> pushToFirestore(Fullname fullname) async {
    if (fullname != null) {
      _firestore.collection('FullNames').add(fullname.toJson());
    }
    return Future.value(true);
  }
}
