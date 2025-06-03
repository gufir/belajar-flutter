class Task {

  String content;
  DateTime timestamp;
  bool isDone;

  Task({
    required this.content, 
    required this.timestamp, 
    this.isDone = false,
    
  });

  factory Task.fromMap(Map task) {
    return Task(
      content: task["content"],
      timestamp: DateTime.parse(task["timestamp"]),
      isDone: task["isDone"],
    );
  }

  Map toMap() {
    return {
      "content": content,
      "timestamp": timestamp.toIso8601String(),
      "isDone": isDone,
    };
  }

}