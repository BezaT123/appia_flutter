import 'dart:async';

import 'package:appia/AppiaData.dart';
import 'package:appia/models/text_message.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessagesLoading());

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    if (event is SendMessage) {
      // get this from the data provider or the services later
      AppiaData.messages_eg1.add(event.message);

      yield MessageSentSuccess(event.message);

      //yield MessageSentFailure();
    } else if (event is LoadMessages) {
      // yield MessagesLoading();
      List<TextMessage> messages = AppiaData.messages_eg1;
      yield MessagesLoadSuccess(messages);
      //yield MessagesLoadFailure();
    }
  }
}
