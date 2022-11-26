import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingsHistory => _firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('meetings')
      .snapshots();

  void addToMeetingHistory(String meetingName, String meetingSubject) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('meetings')
          .add({
        'meetingName': meetingName,
        'meetingSubject': meetingSubject,
        'createdAt': DateTime.now()
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void wipeMeetingHistory() async {
    try {
      var db = _firestore.collection('users').doc(_auth.currentUser!.uid);

      db.collection('meetings').get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          db.collection('meetings').doc(doc.id).delete();
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  
}
