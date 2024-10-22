class Customer {
  final String? id;
  final String name;
  final String teamId;
  final String? email;
  final String? telephone;
  final String? address;
  final String? description;

  Customer({
    required this.name,
    required this.teamId,
    this.id,
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

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
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