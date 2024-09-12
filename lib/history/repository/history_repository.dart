import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common/helper/firbase_helper.dart';

class HistoryRepository {
  final runRef = FirestoreHelper().firestore.collection('run');

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getMyAllRunList({
    int pageLimit = 20,
    DocumentSnapshot? lastDoc,
  }) async {
    debugPrint('==================================================');
    debugPrint('getMyUserList\n');
    debugPrint('lastDoc : $lastDoc\t');
    debugPrint('pageLimit : $pageLimit');
    debugPrint('==================================================');
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return [];

      late QuerySnapshot<Map<String, dynamic>> res;

      if (lastDoc == null) {
        res = await runRef
            .where('managerUid', isEqualTo: '${user.uid}')
            .orderBy('createdAt', descending: true)
            .limit(pageLimit)
            .get();
      } else {
        res = await runRef
            .where('managerUid', isEqualTo: '${user.uid}')
            .orderBy('createdAt', descending: true)
            .startAfterDocument(lastDoc)
            .limit(pageLimit)
            .get();
      }

      return res.docs;
    } catch (e) {
      return [];
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getMyRunList({
    required String runState,
    int pageLimit = 20,
    DocumentSnapshot? lastDoc,
  }) async {
    debugPrint('==================================================');
    debugPrint('getMyUserList\n');
    debugPrint('lastDoc : $lastDoc\t');
    debugPrint('pageLimit : $pageLimit\t');
    debugPrint('runState : $runState');
    debugPrint('==================================================');
    try {
      late QuerySnapshot<Map<String, dynamic>> res;
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return [];

      String dateField = 'completedAt';
      if (runState != 'C') {
        dateField = 'createdAt';
      }

      if (lastDoc == null) {
        res = await runRef
            .where('managerUid', isEqualTo: '${user.uid}')
            .where('runState', isEqualTo: runState)
            .orderBy(dateField, descending: true)
            .limit(pageLimit)
            .get();
      } else {
        res = await runRef
            .where('managerUid', isEqualTo: '${user.uid}')
            .where('runState', isEqualTo: runState)
            .orderBy(dateField, descending: true)
            .startAfterDocument(lastDoc)
            .limit(pageLimit)
            .get();
      }

      return res.docs;
    } catch (e) {
      return [];
    }
  }
}
