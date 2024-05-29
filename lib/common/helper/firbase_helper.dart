import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static final FirestoreHelper _singleton = FirestoreHelper._internal();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirestoreHelper._internal() {
    //
  }

  factory FirestoreHelper() {
    return _singleton;
  }
}
