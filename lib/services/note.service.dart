import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniassist/models/Info.dart';
import 'package:uniassist/models/note.dart';

class NoteService {
  //***** Initialize a Firestore instance
  final Firestore _fs = Firestore.instance;

  ///////////////////////////////
  //***** DOCUMENT READS *****//
  ///////////////////////////////

  //***** Get a note synchronously from Firebase
  Future<Note> getNote(String id) async {
    var snap = await _fs.collection('notes').document(id).get();
    return Note.fromFirestore(snap);
  }

  //***** Get a note asynchronously from Firebase
  Stream<Note> streamNote(String id) {
    return _fs
        .collection('notes')
        .document(id)
        .snapshots()
        .map((snap) => Note.fromFirestore(snap));
  }

  //***** Get a list of a user's notes asynchronously from Firebase
  Stream<List<Note>> streamNotes(FirebaseUser user) {
    var ref = _fs.document(user.uid).collection('notes');
    return ref.snapshots().map(
          (list) => list.documents.map(
            (snap) => Note.fromFirestore(snap),
          ),
        );
  }

  ///////////////////////////////
  //***** DOCUMENT WRITES *****//
  ///////////////////////////////

  Future<Info> addNote(Note note) async {
    try {
      await _fs.collection('notes').document(note.id).setData(note.toJSON());
    } catch (error) {
      return Info(success: false, message: 'Error: ${error.toString()}');
    }
    return Info(success: true, message: 'Note Added Successfully !');
  }

  Future<Info> updateNote(Note note) async {
    try {
      await _fs.collection('notes').document(note.id).setData(
            note.toJSON(),
            merge: true,
          );
    } catch (error) {
      return Info(success: false, message: 'Error: ${error.toString()}');
    }
    return Info(success: true, message: 'Note Updated Successfully !');
  }

  Future<Info> deleteEvent(Note note) async {
    try {
      await _fs.collection('notes').document(note.id).delete();
    } catch (error) {
      return Info(success: false, message: 'Error: ${error.toString()}');
    }
    return Info(success: true, message: 'Note deleted Successfully !');
  }
}