import 'package:note_taking_app/models/basic_note.dart';

class Task extends BasicNote {
  bool _isCompleted;

  Task({required super.title, bool isCompleted = false})
    : _isCompleted = isCompleted;

  Task.internal({
    required super.id,
    required super.madeAt,
    required super.title,
    required bool isCompleted,
    super.editedAt,
  }) : _isCompleted = isCompleted,
       super.internal();

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task.internal(
      id: json['id'],
      madeAt: DateTime.parse(json['madeAt']),
      title: json['title'],
      isCompleted: json['isCompleted'] ?? false,
      editedAt: json['editedAt'] != null
          ? DateTime.parse(json['editedAt'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {...super.toJson(), 'isCompleted': _isCompleted};
  }

  bool get isCompleted => _isCompleted;

  void invert() {
    _isCompleted = !_isCompleted;
  }
}
