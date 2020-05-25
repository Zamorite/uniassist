import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id, noteId, ownerId, type;
  final DateTime period;

  Event({
    this.id,
    this.ownerId,
    this.noteId,
    this.type,
    this.period,
  });

  factory Event.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Event(
      id: doc.documentID ?? '<null>',
      ownerId: data['ownerId'] ?? '<null>',
      noteId: data['noteId'] ?? '<null>',
      type: data['type'] ?? '<null>',
      period: data['period'] ?? '<null>',
    );
  }

  Map toJSON() {
    return {
      id: this.id ?? null,
      ownerId: this.ownerId ?? null,
      noteId: this.noteId ?? null,
      type: this.type ?? null,
      period: this.period ?? null,
    };
  }
}
