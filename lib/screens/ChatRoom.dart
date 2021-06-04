import 'package:appia/blocs/room/room_bloc.dart';
import 'package:appia/blocs/message/message_bloc.dart';
import 'package:appia/models/room.dart';
import 'package:appia/models/text_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';

class ChatRoom extends StatelessWidget {
  Room room;
  ChatRoom(this.room);
  static const routeName = 'ChatRoom';
  final myController = TextEditingController();

  final messageBloc = MessageBloc();
  final roomBloc = RoomBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MessageBloc>(
          create: (context) => messageBloc..add(LoadMessages()),
        ),
        BlocProvider<RoomBloc>(create: (context) => roomBloc),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Will"),
          actions: [
            PopupMenuButton<int>(
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 0,
                        child: Text('Settings'),
                      ),
                      PopupMenuItem(
                        value: 1,
                        child: Text('Block'),
                      ),
                    ]),
          ],
        ),
        body: BlocBuilder<MessageBloc, MessageState>(
          builder: (_, state) {
            if (state is MessageSentSuccess) {
              messageBloc.add(LoadMessages());
              roomBloc.add(AddRoom(room));
            }
            if (state is MessageSentFailure) {
              return Text('Could not load messages');
            }
            if (state is MessagesLoadSuccess) {
              final messages = state.messages;

              return Container(
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, idx) =>
                      MessageUI(message: messages[idx]),
                ),
              );
            }
            print(state);
            return Center(child: CircularProgressIndicator());
          },
        ),
        bottomSheet: Container(
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: TextField(
                  decoration: InputDecoration(hintText: 'Send Message'),
                  controller: myController,
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  TextMessage message = TextMessage(myController.text,
                      id: 6,
                      authorId: MyApp.currentUser.id,
                      authorUsername: MyApp.currentUser.username,
                      timestamp: DateTime.now());
                  MessageEvent event = SendMessage(message);
                  messageBloc.add(event);
                  print(message);
                },
              ),
            ],
          ),
          height: 50,
        ),
      ),
    );
  }

  onSelected(BuildContext context, int item) {}
}

class MessageUI extends StatelessWidget {
  TextMessage message;
  MessageUI({required this.message});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: message.authorUsername != MyApp.currentUser.username
          ? Alignment.centerLeft
          : Alignment.centerRight,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: message.authorUsername != MyApp.currentUser.username
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          // Text(message.senderUsername),
          Container(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width * 0.45,
              maxWidth: MediaQuery.of(context).size.width * 0.67,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.all(
                Radius.circular(MediaQuery.of(context).size.width * 0.05),
              ),
              color: Colors.blue.shade100,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment:
                        message.authorUsername != MyApp.currentUser.username
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                    children: [
                      Flexible(child: Text(message.text)),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      message.timestamp.toString(),
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
