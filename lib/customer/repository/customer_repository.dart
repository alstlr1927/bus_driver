import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../common/helper/firbase_helper.dart';

class CustomerRepository {
  final customerRef = FirestoreHelper().firestore.collection('customer');

  /// [setCustomerRunCount] 고객의 runCount를 1 증가
  Future<bool> setCustomerRunCount({
    required String customerUid,
    required int totalCount,
  }) async {
    debugPrint('==================================================');
    debugPrint('setCustomerRunCount\n');
    debugPrint('customerUid : ${customerUid}\t');
    debugPrint('totalCount : ${totalCount}');
    debugPrint('==================================================');
    try {
      await customerRef.doc(customerUid).update({
        'runCount': FieldValue.increment(totalCount),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  /// [getCustomerList] 전체 고객 리스트를 불러온다
  Future<List<Map<String, dynamic>>> getCustomerList() async {
    debugPrint('==================================================');
    debugPrint('getCustomerList\n');
    debugPrint('==================================================');
    try {
      var res = await customerRef
          .where('enable', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return res.docs.map((e) {
        Map<String, dynamic> data = {};
        data = e.data();
        data['uid'] = e.id;
        return data;
      }).toList();
    } catch (e) {
      return [];
    }
  }

  /// [checkDuplicateNickname] 닉네임 중복체크
  Future<bool> checkDuplicateNickname({
    required String nickname,
  }) async {
    debugPrint('==================================================');
    debugPrint('checkDuplicateNickname\n');
    debugPrint('nickname : $nickname');
    debugPrint('==================================================');
    try {
      var res =
          await customerRef.where('nickname', isEqualTo: '$nickname').get();
      if (res.docs.isNotEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  /// [createCustomer] 고객을 생성한다
  Future<bool> createCustomer({
    required String nickname,
    required String email,
    required String phone,
  }) async {
    debugPrint('==================================================');
    debugPrint('createCustomer\n');
    debugPrint('nickname : $nickname\t');
    debugPrint('email: $email\t');
    debugPrint('phone : $phone');
    debugPrint('==================================================');
    try {
      final Map<String, dynamic> data = {
        'nickname': nickname,
        'email': email,
        'phone': phone,
        'enable': true,
        'runCount': 0,
        'gameList': [],
        'updatedAt': Timestamp.now(),
        'createdAt': Timestamp.now(),
      };
      await customerRef.add(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// [deleteCustomer] 고객을 삭제한다
  Future<bool> deleteCustomer({
    required String managerUid,
    required String customerUid,
    required String nickname,
  }) async {
    debugPrint('==================================================');
    debugPrint('deleteCustomer\n');
    debugPrint('managerUid : $managerUid\t');
    debugPrint('nickname : $nickname\t');
    debugPrint('customerUid : $customerUid');
    debugPrint('==================================================');
    try {
      await customerRef.doc(customerUid).update({
        'enable': false,
        'deleteMangerUid': '$managerUid',
        'nickname': '${nickname}_delete_customer',
        'deletedAt': Timestamp.now(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  // [updateCustomer] 고객 정보를 수정한다
  Future<bool> updateCustomer({
    required String customerUid,
    required String nickname,
    required String email,
    required String phone,
  }) async {
    debugPrint('==================================================');
    debugPrint('updateCustomer\n');
    debugPrint('customerUid : $customerUid\t');
    debugPrint('nickname : $nickname\t');
    debugPrint('email : $email\t');
    debugPrint('phone : $phone');
    debugPrint('==================================================');
    try {
      Map<String, dynamic> data = {
        'nickname': '$nickname',
        'email': '$email',
        'phone': '$phone',
      };
      await customerRef.doc(customerUid).update(data);
      return true;
    } catch (e) {
      return false;
    }
  }
}
