enum SyncActionType { add, update, like }

class SyncItem {
  final String id; // idempotency key
  final SyncActionType type;
  final Map<String, dynamic> payload;
  int retryCount;

  SyncItem({
    required this.id,
    required this.type,
    required this.payload,
    this.retryCount = 0,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.index,
        'payload': payload,
        'retryCount': retryCount,
      };

  factory SyncItem.fromJson(Map json) => SyncItem(
        id: json['id'],
        type: SyncActionType.values[json['type']],
        payload: Map<String, dynamic>.from(json['payload']),
        retryCount: json['retryCount'],
      );
}