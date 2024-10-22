class Supplier {
  final String? id;
  final String name;
  final String teamId;
  final String? email;
  final String? telephone;
  final String? address;
  final String? description;

  Supplier({
    this.id,
    required this.name,
    required this.teamId,
    this.email,
    this.telephone,
    this.address,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'teamId': teamId,
      'email': email,
      'telephone': telephone,
      'address': address,
      'description': description,
    };
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'],
      name: map['name'],
      teamId: map['teamId'],
      email: map['email'],
      telephone: map['telephone'],
      address: map['address'],
      description: map['description'],
    );
  }
}