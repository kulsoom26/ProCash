class Item {
  String? id;
  final String teamId;
  final String name;
  final String barcode;
  final double cost;
  final double price;
  final String image;
  final int quantity;
 List<Map<String, dynamic>>? locations;
  final List<Map<String, String>> attributes;

  Item({
    this.id,
    required this.teamId,
    required this.name,
    required this.barcode,
    required this.cost,
    required this.price,
    required this.image,
    required this.quantity,
    this.locations,
    required this.attributes,
  });

  Map<String, dynamic> toMap() {
    return {
      'teamId': teamId,
      'name': name,
      'barcode': barcode,
      'cost': cost,
      'price': price,
      'image': image,
      'quantity': quantity,
      'locations': locations?.map((location) {
        return {
          'name': location['name'] ?? '',
          'quantity': location['quantity'] ?? 0
        };
      }).toList(),
      'attributes': attributes.map((attribute) {
        return {
          'name': attribute['name'] ?? '',
          'value': attribute['value'] ?? ''
        };
      }).toList(),
    };
  }

  factory Item.fromMap(String id, Map<String, dynamic> map) {
    return Item(
      id: id,
      teamId: map['teamId'] ?? '',
      name: map['name'] ?? '',
      barcode: map['barcode'] ?? '',
      cost: (map['cost'] as num?)?.toDouble() ?? 0.0,
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
      quantity: map['quantity'] ?? 0,
      locations: (map['locations'] as List<dynamic>?)
          ?.map((location) => Map<String, dynamic>.from(location as Map))
          .toList(),
      attributes: (map['attributes'] as List<dynamic>?)
              ?.map((attribute) => Map<String, String>.from(attribute as Map))
              .toList() ??
          [],
    );
  }
}
