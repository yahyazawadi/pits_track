import 'package:note_taking_app/models/basic_note.dart';

class Task extends BasicNote {
  bool _isDone;

  Task({required super.title, bool isDone = false}) : _isDone = isDone;

  Task.internal({
    required super.id,
    required super.madeAt,
    required super.title,
    required bool isDone,
    super.editedAt,
  }) : _isDone = isDone,
       super.internal();

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task.internal(
      id: json['id'],
      madeAt: DateTime.parse(json['madeAt']),
      title: json['title'],
      isDone: json['isDone'] ?? false,
      editedAt: json['editedAt'] != null
          ? DateTime.parse(json['editedAt'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {...super.toJson(), 'isDone': _isDone};
  }

  bool get isDone => _isDone;

  void invert() {
    _isDone = !_isDone;
  }
}
