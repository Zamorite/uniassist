import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  String title, content, ownerId, type;
  DateTime period;

  Note({
    this.id,
    this.title,
    this.content,
    this.ownerId,
    this.type,
    this.period,
  });

  factory Note.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Note(
      id: doc.documentID ?? '<null>',
      title: data['title'] ?? '<null>',
      content: data['content'] ?? '<null>',
      ownerId: data['ownerId'] ?? '<null>',
      type: data['type'] ?? '<null>',
      period: (data['period']).toDate() ?? '<null>',
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': this.id ?? null,
      'title': this.title ?? null,
      'content': this.content ?? null,
      'ownerId': this.ownerId ?? null,
      'type': this.type ?? null,
      'period': this.period ?? null,
    };
  }
}
