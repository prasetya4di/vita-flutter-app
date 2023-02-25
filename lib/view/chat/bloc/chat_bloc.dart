import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vita_client_app/core/di.dart';
import 'package:vita_client_app/data/model/request/reply_message.dart'
    as request2;
import 'package:vita_client_app/data/model/request/send_message.dart'
    as request;
import 'package:vita_client_app/domain/load_message.dart';
import 'package:vita_client_app/domain/load_possibility.dart';
import 'package:vita_client_app/domain/pick_image.dart';
import 'package:vita_client_app/domain/reply_message.dart';
import 'package:vita_client_app/domain/scan_image.dart';
import 'package:vita_client_app/domain/send_message.dart';
import 'package:vita_client_app/util/constant/dummy.dart';
import 'package:vita_client_app/view/chat/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List messages = [];

  ChatBloc() : super(const ChatInitialState()) {
    on<LoadMessageEvent>((event, emit) async {
      emit(const ChatState.loading());
      var loadMessageResult = await di<LoadMessage>().call();
      var loadPossibilityResult = await di<LoadPossibility>().call();
      messages.clear();
      messages.insertAll(0, loadMessageResult);
      if (loadPossibilityResult.length > 1) {
        messages.insert(0, loadPossibilityResult);
      }
      emit(const ChatState.loadedState());
    });

    on<SendMessageEvent>((event, emit) async {
      emit(const ChatState.messageSendingState());
      var message = request.SendMessage(event.message);
      messages.insert(0, message);
      var sendMessageResult = await di<SendMessage>().call(message);
      sendMessageResult.fold((failure) {
        messages.first.isError = true;
        emit(ChatState.error(failure.toString()));
      }, (data) {
        messages.removeAt(0);
        messages.insertAll(0, data.reversed.toList());
        emit(const ChatState.messageSendedState());
      });
    });

    on<ResendMessageEvent>((event, emit) async {
      messages.removeWhere(
          (e) => e is request.SendMessage && e.message == event.message);
      var message = request.SendMessage(event.message);
      messages.insert(0, message);
      emit(const ChatState.messageSendingState());
      var sendMessageResult = await di<SendMessage>().call(message);
      sendMessageResult.fold((failure) {
        messages.first.isError = true;
        emit(ChatState.error(failure.toString()));
      }, (data) {
        messages.removeAt(0);
        messages.insertAll(0, data.reversed.toList());
        emit(const ChatState.messageSendedState());
      });
    });

    on<ScanImageEvent>((event, emit) async {
      emit(const ChatState.imageUploadState());
      var image = await di<PickImage>().call(event.source);
      if (image == null) {
        emit(const ChatState.imageUploadCancelState());
      } else {
        messages.insert(0, image);
        emit(const ChatState.imageSelectedState());
        var uploadResult = await di<ScanImage>().call(image);
        uploadResult.fold(
            (failure) => emit(ChatState.error(failure.toString())), (data) {
          messages.removeAt(0);
          messages.insertAll(0, data.messages.reversed);
          if (data.possibilities.length > 1) {
            messages.insert(0, data.possibilities);
          }
          emit(const ChatState.imageUploadedState());
        });
      }
    });

    on<ReplyMessageEvent>((event, emit) async {
      emit(const ChatState.replyMessageSendingState());
      var message = request2.ReplyMessage(Dummy.email, event.message);
      messages.removeAt(0);
      messages.insert(0, message);
      var sendMessageResult = await di<ReplyMessage>().call(message);
      sendMessageResult
          .fold((failure) => emit(ChatState.error(failure.toString())), (data) {
        messages.removeAt(0);
        messages.insertAll(0, data.reversed.toList());
        emit(const ChatState.replyMessageSendedState());
      });
    });
  }
}
