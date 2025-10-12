class Note {
  String _id;
  String _title;
  DateTime _madeAt;
  DateTime? _editedAt;
  String? _text;
  Note({required String title, String? text})
    : _title = title,
      _text = text,
      _madeAt = DateTime.now(),
      _id = DateTime.now().millisecondsSinceEpoch.toString();
  Note.internal({
    required String id,
    required DateTime madeAt,
    required String title,
    String? text,
    DateTime? editedAt,
  }) : _id = id,
       _madeAt = madeAt,
       _title = title,
       _text = text,
       _editedAt = editedAt;

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note.internal(
      id: json["id"],
      madeAt: DateTime.parse(json["madeAt"]),
      title: json["title"],
      text: json["text"],
      editedAt: json["editedAt"] != null
          ? DateTime.parse(json["editedAt"])
          : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "madeAt": madeAt.toIso8601String(),
      "title": title,
      "text": text,
      "editedAt": editedAt?.toIso8601String(),
    };
  }

  void update({String? title, String? text}) {
    if (text != null) _text = text;
    if (title != null) _title = title;
    _editedAt = DateTime.now();
  }

  String get id => _id;
  String get text => _text ?? "";
  DateTime get madeAt => _madeAt;
  DateTime? get editedAt => _editedAt;
  String get title => _title;
  String get displayDate {
    final now = DateTime.now();
    final diff = now.difference(editedAt ?? madeAt);

    if (diff.inMinutes < 1) {
      return "Just now";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago";
    } else {
      var weeks = (diff.inDays / 7).floor();
      return "$weeks week${weeks == 1 ? '' : 's'} ago";
    }
  }

  //set id(String id) => _id = id;
  // set text(String text) => _text = text;
  //set madeAt(DateTime madeAt) => _madeAt = madeAt;
  set editedAt(DateTime? editedAt) => _editedAt = editedAt;
  // set title(String title) => _title = title;
}
