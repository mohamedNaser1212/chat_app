

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../constant.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  List<Message>messagesList=[];
    sendMessage({required String message, required String email}) {
    try {
      messages.add({kMessage: message, kcreatedAt: DateTime.now(), 'id': email});
    } on Exception catch (e) {

    }
  }
  void getMessages(){
    messages.orderBy(kcreatedAt,descending: true).snapshots().listen((event)
    {
      messagesList.clear();
    for(var doc in event.docs)
      {
        messagesList.add(Message.fromJson(doc));
      }

    emit(ChatSuccess(messages: messagesList));
    });//stream of the


  }
}
