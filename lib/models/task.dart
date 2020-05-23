import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id, content, ownerId, type, status;
  final DateTime deadline;

  Task({
    this.id,
    this.content,
    this.ownerId,
    this.type,
    this.deadline,
    this.status,
  });

  factory Task.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Task(
      id: doc.documentID ?? '<null>',
      content: data['content'] ?? '<null>',
      ownerId: data['ownerId'] ?? '<null>',
      type: data['type'] ?? '<null>',
      deadline: data['deadline'] ?? '<null>',
      status: data['status'] ?? '<null>',
    );
  }
}
