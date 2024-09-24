class NoteModel {
  final int id;
  final String title;
  final String description;
  final String dateTime;

//<editor-fold desc="Data Methods">
  const NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          dateTime == other.dateTime);

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ description.hashCode ^ dateTime.hashCode;

  @override
  String toString() {
    return 'NoteModel{ id: $id, title: $title, description: $description, dateTime: $dateTime,}';
  }

  NoteModel copyWith({
    int? id,
    String? title,
    String? description,
    String? dateTime,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      dateTime: map['dateTime'] as String,
    );
  }

//</editor-fold>
}
