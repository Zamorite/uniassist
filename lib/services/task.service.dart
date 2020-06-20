import 'dart:async';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniassist/models/Info.dart';
import 'package:uniassist/models/task.dart';

class TaskService {
  //***** Initialize a Firestore instance
  final Firestore _fs = Firestore.instance;

  ///////////////////////////////
  //***** DOCUMENT READS *****//
  ///////////////////////////////

  //***** Get a task synchronously from Firebase
  Future<Task> getTask(String id) async {
    var snap = await _fs.collection('tasks').document(id).get();
    return Task.fromFirestore(snap);
  }

  //***** Get a task asynchronously from Firebase
  Stream<Task> streamTask(String id) {
    return _fs
        .collection('tasks')
        .document(id)
        .snapshots()
        .map((snap) => Task.fromFirestore(snap));
  }

  //***** Get a list of a user's tasks asynchronously from Firebase
  Stream<List<Task>> streamTasks(FirebaseUser user) {
    print('User UID: ${user.uid}');
    var ref = _fs.collection('tasks').where('ownerId', isEqualTo: user.uid);
    return ref.snapshots().map(
          (list) => list.documents
              .map(
                (snap) => Task.fromFirestore(snap),
              )
              .toList(),
        );
  }

  ///////////////////////////////
  //***** DOCUMENT WRITES *****//
  ///////////////////////////////

  Future<Info> addTask(Task task) async {
    try {
      await _fs.collection('tasks').document(task.id).setData(task.toJSON());
    } catch (error) {
      return Info(success: false, message: 'Error: ${error.toString()}');
    }
    return Info(success: true, message: 'Task Added Successfully !');
  }

  Future<Info> updateTask(Task task) async {
    try {
      await _fs.collection('tasks').document(task.id).setData(
            task.toJSON(),
            merge: true,
          );
    } catch (error) {
      return Info(success: false, message: 'Error: ${error.toString()}');
    }
    return Info(success: true, message: 'Task Updated Successfully !');
  }

  Future<Info> deleteEvent(Task task) async {
    try {
      await _fs.collection('tasks').document(task.id).delete();
    } catch (error) {
      return Info(success: false, message: 'Error: ${error.toString()}');
    }
    return Info(success: true, message: 'Task deleted Successfully !');
  }
}
