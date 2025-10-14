import 'package:note_taking_app/models/basic_note.dart';

class Note extends BasicNote {
  String? _subText;

  Note({required super.title, String? subText}) {
    _subText = subText;
  }
  Note.internal({
    required super.id,
    required super.madeAt,
    required super.title,
    String? subText,
    super.editedAt,
  }) : super.internal() {
    _subText = subText;
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note.internal(
      id: json["id"],
      madeAt: DateTime.parse(json["madeAt"]),
      title: json["title"],
      subText: json["subText"],
      editedAt: json["editedAt"] != null
          ? DateTime.parse(json["editedAt"])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {...super.toJson(), 'subText': _subText};
  }

  @override
  void update({required String title, String? extraData}) {
    super.update(title: title);
    _subText = extraData;
  }

  String get subText => _subText ?? "";
}
