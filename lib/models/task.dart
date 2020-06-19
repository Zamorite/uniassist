import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  String content, ownerId, type, status;
  DateTime deadline;

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

  Map toJSON() {
    return {
      id: this.id ?? null,
      content: this.content ?? null,
      ownerId: this.ownerId ?? null,
      type: this.type ?? null,
      deadline: this.deadline ?? null,
      status: this.status ?? null,
    };
  }
}
