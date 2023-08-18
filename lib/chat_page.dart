import 'package:chat_app/Cubits/chat_cubit.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constant.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  final _Controller = ScrollController();
  TextEditingController controller = TextEditingController();
  List<Message> messagesList = [];

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //remove the back icon
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Klogo,
              height: 50,
            ),
            const Text(' Chat'),
          ],
        ),
        backgroundColor: KPrimaryColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                    reverse: true,
                    controller: _Controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? ChatBuble(
                              message: messagesList[index],
                            )
                          : ChatBubleForFriend(
                              message: messagesList[index],
                            );
                    });
              },
            ),
          ),






          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              // onSubmitted: (data) {
              //   if (controller.text.isNotEmpty) {
              //     BlocProvider.of<ChatCubit>(context)
              //         .sendMessage(message: data, email: email.toString());
              //   }
              //   _Controller.animateTo(0,
              //       duration: Duration(seconds: 2),
              //       curve: Curves.fastOutSlowIn);
              //   controller.clear();
              // },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: KPrimaryColor),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      BlocProvider.of<ChatCubit>(context)
                          .sendMessage(message: controller.text, email: email.toString());
                    }
                    _Controller.animateTo(0,
                        duration: const Duration(seconds: 2),
                        curve: Curves.fastOutSlowIn);
                    controller.clear();
                  },
                  // Icons.chat_rounded
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                hintText: 'Send Message',
                hintStyle: const TextStyle(),
                enabledBorder: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: KPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
