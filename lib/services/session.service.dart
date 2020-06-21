import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniassist/models/Info.dart';
import 'package:uniassist/models/session.dart';

class SessionService {
  //***** Initialize a Firestore instance
  final Firestore _fs = Firestore.instance;

  ///////////////////////////////
  //***** DOCUMENT READS *****//
  ///////////////////////////////

  //***** Get a session synchronously from Firebase
  Future<Session> getSession(String id) async {
    var snap = await _fs.collection('sessions').document(id).get();
    return Session.fromFirestore(snap);
  }

  //***** Get a session asynchronously from Firebase
  Stream<Session> streamSession(String id) {
    return _fs
        .collection('sessions')
        .document(id)
        .snapshots()
        .map((snap) => Session.fromFirestore(snap));
  }

  //***** Get a list of a user's sessions asynchronously from Firebase
  Stream<List<Session>> streamSessions(FirebaseUser user) {
    var ref = _fs.collection('sessions').where('ownerId', isEqualTo: user.uid);
    return ref.snapshots().map(
          (list) => list.documents
              .map(
                (snap) => Session.fromFirestore(snap),
              )
              .toList(),
        );
  }

  ///////////////////////////////
  //***** DOCUMENT WRITES *****//
  ///////////////////////////////

  Future<Info> addSession(Session session) async {
    try {
      await _fs
          .collection('sessions')
          .document(session.id)
          .setData(session.toJSON());
    } catch (error) {
      return Info(success: false, message: 'Error: ${error.toString()}');
    }
    return Info(success: true, message: 'Session Added Successfully !');
  }

  Future<Info> updateSession(Session session) async {
    try {
      await _fs.collection('sessions').document(session.id).setData(
            session.toJSON(),
            merge: true,
          );
    } catch (error) {
      return Info(success: false, message: 'Error: ${error.toString()}');
    }
    return Info(success: true, message: 'Session Updated Successfully !');
  }

  Future<Info> deleteEvent(Session session) async {
    try {
      await _fs.collection('sessions').document(session.id).delete();
    } catch (error) {
      return Info(success: false, message: 'Error: ${error.toString()}');
    }
    return Info(success: true, message: 'Session deleted Successfully !');
  }
}
