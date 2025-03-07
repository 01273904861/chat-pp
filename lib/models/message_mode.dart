class MessageModel {
  final String? senderEmail;
  final String? text;
  final date;
  factory MessageModel.from(json) {
    return MessageModel(
        text: json['message'], senderEmail: json['sender'], date: json['date']);
  }
  MessageModel(
      {required this.text, required this.senderEmail, required this.date});
}
