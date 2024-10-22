class Request {
  final String? id; 
  final String name;
  final String email;
  final String password;
  final String image;
  final bool isTeamJoined;

  Request({
    this.id, 
    required this.name,
    required this.email,
    required this.password,
    required this.image,
    required this.isTeamJoined,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'image': image,
      'isTeamJoined': isTeamJoined,
    };
  }

  factory Request.fromMap(String id, Map<String, dynamic> map) {
    return Request(
      id: id,
      name: map['name'],
      email: map['email'],
      password: map['password'],
      image: map['image'],
      isTeamJoined: map['isTeamJoined'],
    );
  }
}

