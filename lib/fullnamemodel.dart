import 'package:cloud_firestore/cloud_firestore.dart';

class Fullname {
  String firstName;
  String lastName;
  String documentID;

  Fullname(this.firstName, this.lastName);

  Fullname.fromfirestoresnapshot(DocumentSnapshot snap)
      : documentID = snap.documentID,
        firstName = snap.data['firstName'],
        lastName = snap.data['lastName'];

  toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
