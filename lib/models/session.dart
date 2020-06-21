import 'package:cloud_firestore/cloud_firestore.dart';

class Session {
  final String id;
  String taskId, ownerId;
  Duration duration;
  // DateTime deadline;

  Session({
    this.id,
    // this.taskId,
    this.ownerId,
    this.duration,
  });

  factory Session.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data;

    return Session(
      id: doc.documentID ?? '<null>',
      // taskId: data['taskId'] ?? '<null>',
      ownerId: data['ownerId'] ?? '<null>',
      duration: Duration(seconds: data['duration']) ?? '<null>',
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': this.id ?? null,
      // 'taskId': taskId ?? null,
      'ownerId': ownerId ?? null,
      'duration': duration.inSeconds ?? null,
    };
  }
}
