import 'package:flutter/material.dart';

import '../../common/helper/firbase_helper.dart';
import '../../common/utils/logger.dart';

class ManagerRepository {
  final userRef = FirestoreHelper().firestore.collection('manager');

  /// [checkDuplicatedNickname] 닉네임이 겹치는지 체크 (존재하면 true)
  Future<bool> checkDuplicatedNickname({required String nickname}) async {
    debugPrint('==================================================');
    debugPrint('checkDuplicatedNickname\n');
    debugPrint('nickname : $nickname');
    debugPrint('==================================================');
    try {
      var res = await userRef.where('nickname', isEqualTo: nickname).get();
      if (res.size != 0) {
        GonLog().i('size not zero');
        return true;
      }
      GonLog().i('size zero');
      return false;
    } catch (e, trace) {
      GonLog().e('checkDuplicatedNickname Error : $e');
      GonLog().e('$trace');
      return false;
    }
  }

  /// [createUserByEmail]
  Future<bool> createUserByEmail({
    required String uid,
    required String nickname,
    required String email,
    String profileImageUrl = '',
    String backgroundImageUrl = '',
  }) async {
    debugPrint('==================================================');
    debugPrint('createUserByEmail\n');
    debugPrint('uid : $uid\t');
    debugPrint('nickname : $nickname\t');
    debugPrint('email : $email\t');
    debugPrint('profileImageUrl : $profileImageUrl\t');
    debugPrint('backgroundImageUrl : $backgroundImageUrl');
    debugPrint('==================================================');

    try {
      Map<String, dynamic> data = {
        'uid': uid,
        'nickname': nickname,
        'email': email,
        'profileImageUrl': profileImageUrl,
        'backgroundImageUrl': backgroundImageUrl,
        'grade': 'normal',
      };
      await userRef.doc(uid).set(data);
      return true;
    } catch (e, trace) {
      GonLog().e('createUserByEmail error : ${e}');
      GonLog().e('$trace');
      return false;
    }
  }
}
