import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vita_client_app/core/di.dart';
import 'package:vita_client_app/data/model/entity/image_possibility.dart';
import 'package:vita_client_app/data/model/entity/message.dart';
import 'package:vita_client_app/data/model/request/send_message.dart'
    as request;
import 'package:vita_client_app/domain/load_message.dart';
import 'package:vita_client_app/domain/load_possibility.dart';
import 'package:vita_client_app/domain/pick_image.dart';
import 'package:vita_client_app/domain/scan_image.dart';
import 'package:vita_client_app/domain/send_message.dart';
import 'package:vita_client_app/util/constant/dummy.dart';
import 'package:vita_client_app/view/chat/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<Message> messages = [];
  List<ImagePossibility> possibilities = [];
  request.SendMessage? loadMessage;
  XFile? selectedImage;

  ChatBloc() : super(const ChatInitialState()) {
    on<LoadMessageEvent>((event, emit) async {
      emit(const ChatState.loading());
      var loadMessageResult = await di<LoadMessage>().call();
      var loadPossibilityResult = await di<LoadPossibility>().call();
      messages = loadMessageResult;
      possibilities = loadPossibilityResult;
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

    on<ScanImageEvent>((event, emit) async {
      emit(const ChatState.imageUploadState());
      var image = await di<PickImage>().call(event.source);
      if (image == null) {
        emit(const ChatState.imageUploadCancelState());
      } else {
        selectedImage = image;
        emit(const ChatState.imageSelectedState());
        var uploadResult = await di<ScanImage>().call(image);
        uploadResult.fold(
            (failure) => emit(ChatState.error(failure.toString())), (data) {
          possibilities = data.possibilities;
          selectedImage = null;
          messages.insertAll(0, data.messages.reversed);
          emit(const ChatState.imageUploadedState());
        });
      }
    });
  }
}
