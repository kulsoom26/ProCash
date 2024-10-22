class StockRequest {
  final String date; 
  final String itemId; 
  final String itemName;
  final String? location; 
  final int quantity;
  final String? toLocation; 
  final String? supplier; 
  final String? note;
  final String? customer;
  final String type;
  final String image;
  final String userName;
  final String stockedBy;
  final String teamId;

  StockRequest({
    required this.date,
    required this.itemId,
    required this.itemName,
    this.location,
    required this.quantity,
    this.toLocation,
    this.supplier,
    this.note,
    this.customer,
    required this.type,
    required this.image,
    required this.userName,
    required this.stockedBy,
    required this.teamId
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'itemId': itemId,
      'itemName': itemName,
      'location': location,
      'quantity': quantity,
      'toLocation': toLocation,
      'supplier': supplier,
      'note': note,
      'customer': customer,
      'type':type,
      'image': image,
      'userName': userName,
      'stockedBy': stockedBy,
      'teamId' : teamId
    };
  }

  factory StockRequest.fromMap(Map<String, dynamic> map) {
    return StockRequest(
      date: map['date'],
      itemId: map['itemId'],
      itemName: map['itemName'],
      location: map['location'],
      quantity: map['quantity'],
      toLocation: map['toLocation'],
      supplier: map['supplier'],
      note: map['note'],
      customer: map['customer'],
      type: map['type'],
      image: map['image'],
      userName: map['userName'],
      stockedBy: map['stockedBy'],
      teamId: map['teamId']
    );
  }
}
