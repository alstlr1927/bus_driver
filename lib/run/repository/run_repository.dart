import 'package:bus_counter/common/helper/firbase_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RunRepository {
  final runRef = FirestoreHelper().firestore.collection('run');
  final customerRef = FirestoreHelper().firestore.collection('customer');

  Future<bool> createRun({
    required String customerName,
    required String customerUid,
    required String managerUid,
    required String gameName,
    required int totalCount,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'completedAt': null,
        'completedCount': 0,
        'createdAt': Timestamp.now(),
        'customerUid': '$customerUid',
        'managerUid': '$managerUid',
        'nickname': '$customerName',
        'remainingCount': totalCount,
        'runState': 'R',
        'totalCount': totalCount,
        'gameName': gameName,
      };
      await runRef.add(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addCustomerGame({
    required String customerUid,
    required String gameName,
  }) async {
    try {
      await customerRef.doc(customerUid).update({
        'gameList': FieldValue.arrayUnion([gameName]),
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
