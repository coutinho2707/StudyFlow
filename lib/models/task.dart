class Task {
  final int? id;
  final String title;
  final String description;
  final bool done;
  final String? tag;
  final String? tagType;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.done,
    this.tag,
    this.tagType,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'done': done ? 1 : 0,
      'tag': tag,
      'tagType': tagType,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      done: map['done'] == 1,
      tag: map['tag'],
      tagType: map['tagType'],
    );
  }
}