class Session {
  final String id, taskId, ownerId;
  final Duration duration;

  Session({
    this.id,
    this.taskId,
    this.ownerId,
    this.duration,
  });
}
