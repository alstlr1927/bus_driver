import 'package:flutter/material.dart';

import '../../common/helper/firbase_helper.dart';

class HistoryRepository {
  final runRef = FirestoreHelper().firestore.collection('run');

  Future<List<Map<String, dynamic>>> getMyRunList({
    required String managerUid,
    required String runState,
  }) async {
    debugPrint('==================================================');
    debugPrint('getMyUserList\n');
    debugPrint('managerUid : $managerUid\t');
    debugPrint('runState : $runState');
    debugPrint('==================================================');
    try {
      String dateField = 'completedAt';
      if (runState != 'C') {
        dateField = 'createdAt';
      }

      if (runState == 'A') {
        var res = await runRef
            .where('managerUid', isEqualTo: '$managerUid')
            .orderBy('createdAt', descending: true)
            .get();

        return res.docs.map((e) {
          Map<String, dynamic> data = {};
          data = e.data();
          data['id'] = e.id;
          return data;
        }).toList();
      } else {
        var res = await runRef
            .where('managerUid', isEqualTo: '$managerUid')
            .where('runState', isEqualTo: runState)
            .orderBy(dateField, descending: true)
            .get();

        return res.docs.map((e) {
          Map<String, dynamic> data = {};
          data = e.data();
          data['id'] = e.id;
          return data;
        }).toList();
      }
    } catch (e) {
      return [];
    }
  }
}
