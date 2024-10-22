class TransferRequest {
  final String type;
  final String warehouse;
  final String quantity;
  final String item;
  final String requester;
  final String itemId;

  TransferRequest({
    required this.type,
    required this.warehouse,
    required this.quantity,
    required this.item,
    required this.requester,
    required this.itemId,
  });
}
