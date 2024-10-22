import 'attributes_model.dart';

class Team {
  String? id;
  final String code;
  final String name;
  final String description;
  final String image;
  final String mode;
  final List<String>? locations;
  final List<String> items;
  final String adminId;
  final List<String> members;
  final List<String> customers; // Updated
  final List<String> suppliers; // Updated
  final List<Attribute> attributes;

  Team({
    this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.image,
    required this.mode,
    this.locations,
    required this.adminId,
    this.items = const [],
    this.members = const [],
    this.customers = const [], // Updated
    this.suppliers = const [], // Updated
    required this.attributes,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'description': description,
      'image': image,
      'mode': mode,
      'locations': locations,
      'adminId': adminId,
      'items': items,
      'members': members,
      'customers': customers, // Updated
      'suppliers': suppliers, // Updated
      'attributes': attributes.map((attribute) => attribute.toMap()).toList(),
    };
  }

  factory Team.fromMap(String id, Map<String, dynamic> map) {
    return Team(
      id: id,
      code: map['code'],
      name: map['name'],
      description: map['description'],
      image: map['image'],
      mode: map['mode'],
      locations: (map['locations'] as List<dynamic>?)?.map((e) => e as String).toList(),
      items: (map['items'] as List<dynamic>).map((e) => e as String).toList(),
      adminId: map['adminId'],
      members: (map['members'] as List<dynamic>).map((e) => e as String).toList(),
      customers: (map['customers'] as List<dynamic>).map((e) => e as String).toList(), // Updated
      suppliers: (map['suppliers'] as List<dynamic>).map((e) => e as String).toList(), // Updated
      attributes: (map['attributes'] as List<dynamic>)
          .map((attribute) => Attribute.fromMap(attribute as Map<String, dynamic>))
          .toList(),
    );
  }
}
