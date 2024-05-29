import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../common/helper/firbase_helper.dart';

class GameRepository {
  final gameRef = FirestoreHelper().firestore.collection('game');

  Future<bool> checkDuplicateGameName({required String name}) async {
    debugPrint('==================================================');
    debugPrint('checkDuplicateGameName');
    debugPrint('name : $name');
    debugPrint('==================================================');
    try {
      var res = await gameRef.doc(name).get();
      if (res.exists) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> createGame({required String name}) async {
    debugPrint('==================================================');
    debugPrint('createGame');
    debugPrint('name : $name');
    debugPrint('==================================================');
    try {
      await gameRef.doc(name).set({
        'name': '$name',
        'createdAt': Timestamp.now(),
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getGameList() async {
    debugPrint('==================================================');
    debugPrint('getGameList');
    debugPrint('==================================================');
    try {
      var res = await gameRef.get();

      return res.docs.map((e) {
        Map<String, dynamic> data = {};
        data = e.data();
        return data;
      }).toList();
    } catch (e) {
      return [];
    }
  }
}
