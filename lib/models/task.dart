class Task {
  String id;
  String description;
  String owner;
  bool completed;
  Task(
    this.id,
    this.description,
    this.owner,
    this.completed,
  );
  factory Task.fromJson(Map<String, dynamic> jsonObj) {
    return Task(
      jsonObj['_id'],
      jsonObj['description'],
      jsonObj['owner'],
      jsonObj['completed'],
    );
  }
}
