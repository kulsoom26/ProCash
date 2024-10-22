class Notes {
  final String note;
  final String teamId;

  Notes({
    required this.note,
    required this.teamId,
  });

  Map<String, dynamic> toMap() {
    return {
      'note': note,
      'teamId': teamId,
    };
  }

  factory Notes.fromMap(String id, Map<String, dynamic> map) {
    return Notes(
      note: map['note'],
      teamId: map['teamId']
    );
  }
}
