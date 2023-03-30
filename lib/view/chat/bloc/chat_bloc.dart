import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
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
  final LoadMessage _loadMessage;
  final LoadPossibility _loadPossibility;
  final SendMessage _sendMessage;
  final PickImage _pickimage;
  final ScanImage _scanImage;
  final ReplyMessage _replyMessage;

  List messages = [];

  ChatBloc(this._loadMessage, this._loadPossibility, this._sendMessage,
      this._pickimage, this._scanImage, this._replyMessage)
      : super(const ChatInitialState()) {
    on<LoadMessageEvent>((event, emit) async {
      emit(const ChatState.loading());
      var loadMessageResult = await _loadMessage.call();
      var loadPossibilityResult = await _loadPossibility.call();
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
        return await _sendMessage.call(message);
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
        return await _sendMessage.call(message);
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
      await Task(() => _pickimage.call(event.source)).run().then((image) {
        throwIf(image == null, ImageNotSelected());
        var uploadImage = UploadImage(image!);
        messages.insert(0, uploadImage);
        emit(const ChatState.imageSelectedState());
        return Task(() => _scanImage.call(image)).run();
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
        return _scanImage.call(event.image);
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
        return _replyMessage.call(message);
      }).run().then((data) {
        // Todo : Handle error when reply message failed
        data.fold((l) => emit(ChatState.error(l.message)), (r) {
          messages.removeAt(0);
          messages.insertAll(0, r.reversed.toList());
          emit(const ChatState.replyMessageSendedState());
        });
      }).catchError((error) {
        emit(ChatState.error(error.toString()));
      });
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
}
