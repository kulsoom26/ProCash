class Attribute {
  final String name;
  final String type;

  Attribute({
    required this.name,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
    };
  }

  factory Attribute.fromMap(Map<String, dynamic> map) {
    return Attribute(
      name: map['name'],
      type: map['type'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Attribute &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          type == other.type;

  @override
  int get hashCode => name.hashCode ^ type.hashCode;
}