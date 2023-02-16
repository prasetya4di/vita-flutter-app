import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vita_client_app/core/di.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/send_message.dart'
    as request;
import 'package:vita_client_app/domain/load_message.dart';
import 'package:vita_client_app/domain/send_message.dart';
import 'package:vita_client_app/util/constant/dummy.dart';
import 'package:vita_client_app/view/chat/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<Message> messages = [];
  request.SendMessage? loadMessage;

  ChatBloc() : super(const ChatInitialState()) {
    on<LoadMessageEvent>((event, emit) async {
      emit(const ChatState.loading());
      var loadMessageResult = await di<LoadMessage>().call();
      messages = loadMessageResult;
      emit(const ChatState.loadedState());
    });

    on<SendMessageEvent>((event, emit) async {
      emit(const ChatState.messageSendingState());
      var message = request.SendMessage(Dummy.email, event.message);
      loadMessage = message;
      var sendMessageResult = await di<SendMessage>().call(message);
      sendMessageResult
          .fold((failure) => emit(ChatState.error(failure.toString())), (data) {
        messages.insertAll(0, data.reversed.toList());
        loadMessage = null;
        emit(const ChatState.messageSendedState());
      });
    });
  }
}
