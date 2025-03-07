
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_2/constants.dart';
import 'package:my_chat_2/functions/helper_functions.dart';
import 'package:my_chat_2/models/message_mode.dart';
import 'package:my_chat_2/widgets/custom_buble_message.dart';
import 'package:my_chat_2/widgets/custom_send_message.dart';

class ChatPage extends StatefulWidget {
  ChatPage(
      {super.key,
      required this.name,
      required this.email,
      required this.username,
      required this.profilePic,
      required this.senderUsername});
  String name, username, profilePic, email, senderUsername;
  static String id = 'chatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String? inputText;

  final ScrollController scrollController = ScrollController();

  String chatroomId = '';
  CollectionReference? messages;
  @override
  void initState() {
    super.initState();
    chatroomId = HelperFunctions()
        .getchatroomIdbyUsersname(widget.username, widget.senderUsername);

    messages = FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatroomId)
        .collection(kMessages);
  }

  var currentUser = FirebaseAuth.instance.currentUser;

  TextEditingController txtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messages!.orderBy('date', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> texts = [];
            for (var text in snapshot.data!.docs) {
              texts.add(MessageModel.from(text));
            }
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.blueGrey,
                  title: Text(widget.name),
                ),
                body: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount: texts.length,
                      itemBuilder: (context, i) {
                        return currentUser!.email == texts[i].senderEmail
                            ? BubleSendMessage(text: texts[i].text!)
                            : BubleReceiveMessage(text: texts[i].text!);
                      },
                    )),
                    SendMessageTextForm(
                      onPressedButton: () {
                        if (txtController.text != '') {
                          messages!.add({
                            'message': txtController.text,
                            'sender': currentUser!.email,
                            'date': DateTime.now(),
                          });
                          txtController.clear();
                          scrollController.animateTo(
                              scrollController.position.minScrollExtent,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeIn);
                        } else {
                          HelperFunctions().scaffoldMessengerMassage(
                              'please enter a non empty value', context);
                        }
                      },
                      controller: txtController,
                      onSubmitted: (String val) {
                        if (val != '' && val.isNotEmpty) {
                          messages!.add({
                            'message': txtController.text,
                            'sender': currentUser!.email,
                            'date': DateTime.now(),
                          });
                          inputText = val;
                          txtController.clear();
                          scrollController.animateTo(
                              scrollController.position.minScrollExtent,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeIn);
                        } else {
                          HelperFunctions().scaffoldMessengerMassage(
                              'please enter a non value', context);
                        }
                      },
                    ),
                  ],
                ));
          } else {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
