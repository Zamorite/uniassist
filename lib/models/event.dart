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
}
