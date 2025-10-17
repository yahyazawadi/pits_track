abstract class BasicNote {
  final String _id;
  String _title;
  final DateTime _madeAt;
  DateTime? _editedAt;

  BasicNote({required String title})
    : _title = title,
      _madeAt = DateTime.now(),
      _id = DateTime.now().millisecondsSinceEpoch.toString();

  BasicNote.internal({
    required String id,
    required DateTime madeAt,
    required String title,
    DateTime? editedAt,
  }) : _id = id,
       _madeAt = madeAt,
       _title = title,
       _editedAt = editedAt;

  void update({required String title, String? subText}) {
    _title = title;
    _editedAt = DateTime.now();
  }

  String get id => _id;
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

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'madeAt': _madeAt.toIso8601String(),
      'title': _title,
      'editedAt': _editedAt?.toIso8601String(),
    };
  }

  String? get subText => null;
}
