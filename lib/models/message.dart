class Sender {
  final String role;
  final String email;

  Sender({required this.email, required this.role});
}

class Message {
  final String text;
  final String status;
  final num timestamp;
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
    try {
      return Message(
        text: json['text'] ?? '',
        status: json['status'] ?? '',
        timestamp: json['timestamp'] ?? 0,
        sender: '',
        contactId: json['contactId'] ?? '',
        eventDirection: json['eventDirection'] ?? '',
        media: json['media'] ?? '',
        context: json['context'] ?? '',
        messageId: json['messageId'] ?? '',
      );
    } catch (e) {
      print(e);
      print(json);
    }
    return Message.fromJson({});
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'status': status,
      'timestamp': timestamp,
      'sender': sender,
      'contactId': contactId,
      'eventDirection': eventDirection,
      'media': media,
      'context': context,
      'messageId': messageId,
    };
  }
}
