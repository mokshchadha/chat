class Message {
  final String text;
  final String status;
  final DateTime timestamp;
  final String sender;
  final String contactId;
  final String eventDirection;
  final String media;
  final String context;
  final String messageId;

  Message({
    required this.text,
    required this.status,
    required this.timestamp,
    required this.sender,
    required this.contactId,
    required this.eventDirection,
    required this.media,
    required this.context,
    required this.messageId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'] as String,
      status: json['status'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      sender: json['sender'] as String,
      contactId: json['contactId'] as String,
      eventDirection: json['eventDirection'] as String,
      media: json['media'] as String,
      context: json['context'] as String,
      messageId: json['messageId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
      'sender': sender,
      'contactId': contactId,
      'eventDirection': eventDirection,
      'media': media,
      'context': context,
      'messageId': messageId,
    };
  }
}
