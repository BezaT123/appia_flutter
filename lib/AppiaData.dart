import 'package:appia/appia.dart';
import 'package:appia/models/room.dart';
import 'package:appia/models/user.dart';
import 'package:appia/models/text_message.dart';

class AppiaData {
  static List<Room> chatRoom = [
    Room(RoomType.personalChat, [user1, user2], messages_eg1),
    Room(RoomType.personalChat, [user3, user4], messages_eg1),
  ];
  static List<TextMessage> messages_eg1 = [
    TextMessage("Hello",
        id: 1,
        authorId: "2",
        authorUsername: "Will",
        timestamp: DateTime.now()),
    TextMessage("Hi, who is this?",
        id: 2,
        authorId: "7",
        authorUsername: "Jada",
        timestamp: DateTime.now()),
    TextMessage("Oh sorry, do I have the wrong number?",
        id: 3,
        authorId: "2",
        authorUsername: "Will",
        timestamp: DateTime.now()),
    TextMessage("Well, who are you looking for?",
        id: 4,
        authorId: "7",
        authorUsername: "Jada",
        timestamp: DateTime.now()),
    TextMessage("Oh sorry, I do have the wrong number. Have a nice day.",
        id: 5,
        authorId: "2",
        authorUsername: "Will",
        timestamp: DateTime.now()),
    TextMessage("Okay",
        id: 6,
        authorId: "7",
        authorUsername: "Jada",
        timestamp: DateTime.now()),
  ];
  static List<TextMessage> messages_eg2 = [
    TextMessage(
      "Hello",
      id: 7,
      authorId: "6",
      authorUsername: "Ken",
      timestamp: DateTime.now(),
    ),
    TextMessage("Hi, who is this?",
        id: 8,
        authorId: "8",
        authorUsername: "Barbie",
        timestamp: DateTime.now()),
    TextMessage(
      "Insert some text here",
      id: 9,
      authorId: "6",
      authorUsername: "Ken",
      timestamp: DateTime.now(),
    ),
    TextMessage("What?",
        id: 10,
        authorId: "8",
        authorUsername: "Barbie",
        timestamp: DateTime.now()),
    TextMessage(
      "Insert some text here",
      id: 11,
      authorId: "6",
      authorUsername: "Ken",
      timestamp: DateTime.now(),
    ),
    TextMessage("Goodbye",
        id: 12,
        authorId: "8",
        authorUsername: "Barbie",
        timestamp: DateTime.now()),
  ];
  static User user1 = User("Will", "2");
  static User user2 = User("Jada", "7");
  static User user3 = User("Ken", "6");
  static User user4 = User("Barbie", "8");
}
