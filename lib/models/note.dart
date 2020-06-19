import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  String content, ownerId, type;
  DateTime period;

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

  Map toJSON() {
    return {
      id: this.id ?? null,
      content: this.content ?? null,
      ownerId: this.ownerId ?? null,
      type: this.type ?? null,
      period: this.period ?? null,
    };
  }
}
