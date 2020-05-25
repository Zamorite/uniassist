import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniassist/models/Info.dart';
import 'package:uniassist/models/event.dart';

class EventService {
  //***** Initialize a Firestore instance
  final Firestore _fs = Firestore.instance;

  ///////////////////////////////
  //***** DOCUMENT READS *****//
  ///////////////////////////////

  //***** Get an event synchronously from Firebase
  Future<Event> getEvent(String id) async {
    var snap = await _fs.collection('events').document(id).get();
    return Event.fromFirestore(snap);
  }

  //***** Get an event asynchronously from Firebase
  Stream<Event> streamEvent(String id) {
    return _fs
        .collection('events')
        .document(id)
        .snapshots()
        .map((snap) => Event.fromFirestore(snap));
  }

  //***** Get a list of a user's events asynchronously from Firebase
  Stream<List<Event>> streamEvents(FirebaseUser user) {
    var ref = _fs.document(user.uid).collection('events');
    return ref.snapshots().map(
          (list) => list.documents.map(
            (snap) => Event.fromFirestore(snap),
          ),
        );
  }

  ///////////////////////////////
  //***** DOCUMENT WRITES *****//
  ///////////////////////////////

  Future<Info> addEvent(Event event) async {
    try {
      await _fs.collection('events').document(event.id).setData(event.toJSON());
    } catch (error) {
      return Info(success: false, message: 'Error: ${error.toString()}');
    }
    return Info(success: true, message: 'Event Added Successfully !');
  }

  Future<Info> updateEvent(Event event) async {
    try {
      await _fs.collection('events').document(event.id).setData(
            event.toJSON(),
            merge: true,
          );
    } catch (error) {
      return Info(success: false, message: 'Error: ${error.toString()}');
    }
    return Info(success: true, message: 'Event Updated Successfully !');
  }

  Future<Info> deleteEvent(Event event) async {
    try {
      await _fs.collection('events').document(event.id).delete();
    } catch (error) {
      return Info(success: false, message: 'Error: ${error.toString()}');
    }
    return Info(success: true, message: 'Event deleted Successfully !');
  }
}
