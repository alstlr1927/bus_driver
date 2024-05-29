import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/helper/firbase_helper.dart';
import '../../common/utils/logger.dart';

class LoginRepository {
  final userRef = FirestoreHelper().firestore.collection('manager');

  /// [getUserByUid] uid로 유저를 가져온다
  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserByUid(
      {required String uid}) async {
    try {
      var res = await userRef.doc(uid).get();

      GonLog().i('res : ${res.data()}');

      return res;
    } catch (e, trace) {
      GonLog().e('getUserByUid Error : $e');
      GonLog().e('$trace');
      return null;
    }
  }
}
