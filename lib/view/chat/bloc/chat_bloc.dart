import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vita_client_app/core/di.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/domain/load_message.dart';
import 'package:vita_client_app/view/chat/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<Message> messages = [];

  ChatBloc() : super(const ChatInitialState()) {
    on<LoadMessageEvent>((event, emit) async {
      emit(const ChatState.loading());
      var loadMessageResult = await di<LoadMessage>().call();
      messages.addAll(loadMessageResult);
      emit(const ChatState.loadedState());
    });
  }
}
