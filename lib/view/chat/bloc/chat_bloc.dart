import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vita_client_app/core/di.dart';
import 'package:vita_client_app/data/model/request/reply_message.dart'
as request2;
import 'package:vita_client_app/data/model/request/send_message.dart'
as request;
import 'package:vita_client_app/data/model/request/upload_image.dart';
import 'package:vita_client_app/domain/load_message.dart';
import 'package:vita_client_app/domain/load_possibility.dart';
import 'package:vita_client_app/domain/pick_image.dart';
import 'package:vita_client_app/domain/reply_message.dart';
import 'package:vita_client_app/domain/scan_image.dart';
import 'package:vita_client_app/domain/send_message.dart';
import 'package:vita_client_app/view/chat/bloc/chat_error.dart';
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
      await Task(() async {
        var message = request.SendMessage(event.message);
        messages.insert(0, message);
        return await di<SendMessage>().call(message);
      }).run().then((value) {
        messages.removeAt(0);
        messages.insertAll(0, value.reversed.toList());
        emit(const ChatState.messageSendedState());
      }).catchError((error) {
        messages.first.isError = true;
        emit(ChatState.error(error.toString()));
      });
    });

    on<ResendMessageEvent>((event, emit) async {
      emit(const ChatState.messageSendingState());
      await Task(() async {
        messages.removeWhere(
            (e) => e is request.SendMessage && e.message == event.message);
        var message = request.SendMessage(event.message);
        messages.insert(0, message);
        return await di<SendMessage>().call(message);
      }).run().then((value) {
        messages.removeAt(0);
        messages.insertAll(0, value.reversed.toList());
        emit(const ChatState.messageSendedState());
      }).catchError((error) {
        messages.first.isError = true;
        emit(ChatState.error(error.toString()));
      });
    });

    on<ScanImageEvent>((event, emit) async {
      emit(const ChatState.imageUploadState());
      await Task(() => di<PickImage>().call(event.source)).run().then((image) {
        throwIf(image == null, ImageNotSelected());
        var uploadImage = UploadImage(image!);
        messages.insert(0, uploadImage);
        emit(const ChatState.imageSelectedState());
        return Task(() => di<ScanImage>().call(image)).run();
      }).then((data) {
        messages.removeAt(0);
        messages.insertAll(0, data.messages.reversed);
        if (data.possibilities.length > 1) {
          messages.insert(0, data.possibilities);
        }
        emit(const ChatState.imageUploadedState());
      }).catchError((error) {
        if (error is ImageNotSelected) {
          emit(const ChatState.imageUploadCancelState());
        } else {
          messages.first.isError = true;
          emit(ChatState.error(error.toString()));
        }
      });
    });

    on<RescanImageEvent>((event, emit) async {
      emit(const ChatState.imageUploadState());
      await Task(() {
        messages.removeWhere(
            (e) => e is UploadImage && e.image.path == event.image.path);
        var uploadImage = UploadImage(event.image);
        messages.insert(0, uploadImage);
        return di<ScanImage>().call(event.image);
      }).run().then((data) {
        messages.removeAt(0);
        messages.insertAll(0, data.messages.reversed);
        if (data.possibilities.length > 1) {
          messages.insert(0, data.possibilities);
        }
        emit(const ChatState.imageUploadedState());
      }).catchError((error) {
        messages.first.isError = true;
        emit(ChatState.error(error.toString()));
      });
    });

    on<ReplyMessageEvent>((event, emit) async {
      emit(const ChatState.replyMessageSendingState());
      await Task(() {
        var message = request2.ReplyMessage(event.message);
        messages.removeAt(0);
        messages.insert(0, message);
        return di<ReplyMessage>().call(message);
      }).run().then((data) {
        messages.removeAt(0);
        messages.insertAll(0, data.reversed.toList());
        emit(const ChatState.replyMessageSendedState());
      }).catchError((error) {
        emit(ChatState.error(error.toString()));
      });
    });
  }
}
