import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id, content, ownerId, type;
  final DateTime period;

  Note({
    this.id,
    this.content,
    this.ownerId,
    this.type,
    this.period,
  });

  factory Note.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Note(
      id: doc.documentID ?? '<null>',
      content: data['content'] ?? '<null>',
      ownerId: data['ownerId'] ?? '<null>',
      type: data['type'] ?? '<null>',
      period: data['period'] ?? '<null>',
    );
  }
}
