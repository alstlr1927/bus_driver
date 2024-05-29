import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helper/firbase_helper.dart';

class GonRepository {
  final runRef = FirestoreHelper().firestore.collection('run');
  final appRef = FirestoreHelper().firestore.collection('app');

  Future<String> getMinVersion() async {
    DocumentSnapshot docData;
    docData = await appRef.doc('version').get();
    return (docData.data() as Map<String, dynamic>)['min_version'] ?? '1.0.0';
  }

  Future<String> getLatestVersion() async {
    DocumentSnapshot docData;
    docData = await appRef.doc('version').get();

    return (docData.data() as Map<String, dynamic>)['latest_version'] ??
        '1.0.0';
  }

  Future<List<Map<String, dynamic>>> getRunningList({
    required String managerUid,
  }) async {
    debugPrint('==================================================');
    debugPrint('getRunningList\n');
    debugPrint('managerUid : $managerUid');
    debugPrint('==================================================');
    try {
      var res = await runRef
          .where('managerUid', isEqualTo: '$managerUid')
          .where('runState', isEqualTo: 'R')
          .limit(3)
          .orderBy('createdAt', descending: true)
          .get();

      return res.docs.map((e) {
        Map<String, dynamic> data = {};
        data = e.data();
        data['id'] = e.id;
        return data;
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> setCountRun({
    required String runId,
  }) async {
    debugPrint('==================================================');
    debugPrint('setCountRun\n');
    debugPrint('runId : $runId');
    debugPrint('==================================================');
    try {
      Map<String, dynamic> data = {
        'remainingCount': FieldValue.increment(-1),
        'completedCount': FieldValue.increment(1),
      };
      await runRef.doc(runId).update(data);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setExtendRun({
    required String runId,
    required int count,
  }) async {
    debugPrint('==================================================');
    debugPrint('setExtendRun\n');
    debugPrint('runId : $runId\t');
    debugPrint('count : $count');
    debugPrint('==================================================');
    try {
      Map<String, dynamic> data = {
        'remainingCount': FieldValue.increment(count),
        'totalCount': FieldValue.increment(count),
      };
      await runRef.doc(runId).update(data);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setCompleteRun({
    required String runId,
  }) async {
    debugPrint('==================================================');
    debugPrint('setCompleteRun\n');
    debugPrint('runId : $runId');
    debugPrint('==================================================');
    try {
      Map<String, dynamic> data = {
        'runState': 'C',
        'completedAt': Timestamp.now(),
      };
      await runRef.doc(runId).update(data);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setDeleteRun({
    required String runId,
  }) async {
    debugPrint('==================================================');
    debugPrint('setDeleteRun\n');
    debugPrint('runId : $runId');
    debugPrint('==================================================');
    try {
      Map<String, dynamic> data = {
        'runState': 'D',
        'deletedAt': Timestamp.now(),
      };
      await runRef.doc(runId).update(data);

      return true;
    } catch (e) {
      return false;
    }
  }
}
