import 'package:appia/models/text_message.dart';

import 'room_entry.dart';

abstract class Message extends RoomEntry {
  final String authorId;
  final String authorUsername;
  final String? forwadedFromId;
  final String? forwardedFromUsername;

  const Message(
      {required int id,
      required this.authorId,
      required this.authorUsername,
      required DateTime timestamp,
      this.forwadedFromId,
      this.forwardedFromUsername})
      : super(id, EntryType.message, timestamp);

  // TODO: fuck me this is bad. Find alternatives.
  factory Message.fromJson(Map<String, dynamic> json) {
    if (json['text'] != null) {
      return TextMessage.fromJson(json);
    }
    throw Exception('Invalid JSON: unrecognized text message type');
  }
  /*  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson()
      ..addAll({
        "authorId": authorId.toString(),
        "authorUsername": authorUsername,
        "timestamp": timestamp.toIso8601String(),
      });
    if (forwardedFromUsername != null) {
      json['forwardedFromUsername'] = forwardedFromUsername;
      json['forwadedFromId'] = forwadedFromId.toString();
    }
    return json;
  } */
}
