import 'package:cloud_firestore/cloud_firestore.dart';

class DataUtils {
  static DateTime timestampToDateTime(Timestamp ts) {
    return ts.toDate();
  }

  static DateTime? timestampToDateTimeNull(Timestamp? ts) {
    if (ts != null) {
      return ts.toDate();
    } else {
      return null;
    }
  }
}
