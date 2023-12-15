import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../Helpers/Authentication_Helper/auth_helper.dart';
import '../../../Helpers/Cloud_firestore_helper/firestore_helper.dart';
import '../../../Stream/stream.dart';
import '../Model/chat_model.dart';
import '../Model/receiver_model.dart';

class Chat_Screen extends StatelessWidget {
  Chat_Screen({super.key});

  TextEditingController messageController = TextEditingController();
  String? message;

  @override
  Widget build(BuildContext context) {
    Receiver receiver = ModalRoute.of(context)!.settings.arguments as Receiver;

    return Scaffold(
      backgroundColor: const Color(0xffF7F9FB),
      appBar: AppBar(
        title: Text(receiver.name),
        centerTitle: true,
        actions: [
          CircleAvatar(
            radius: 30,
            foregroundImage: NetworkImage(receiver.photo),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: messageData,
                builder: (ctx, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    QuerySnapshot? querysnapshot = snapshot.data;
                    List<QueryDocumentSnapshot>? chats = querysnapshot?.docs;
                    return (chats!.isEmpty == true)
                        ? Center(
                            child: Container(
                              height: 300,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://cdn.dribbble.com/users/411641/screenshots/3921966/listen.gif"),
                                ),
                              ),
                            ),
                          )
                        : ListView.builder(
                            reverse: true,
                            itemCount: chats.length,
                            itemBuilder: (ctx, i) {
                              return Row(
                                mainAxisAlignment: (Auth_helper.auth_helper
                                            .firebaseAuth.currentUser?.uid ==
                                        chats[i]['sentby'])
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Chip(
                                          label:
                                              Text("${chats[i]['message']}")),
                                      (chats[i]['timestamp'] == null)
                                          ? const Text(" ")
                                          : Text(
                                              "${chats[i]['timestamp'].toDate().toString().split(" ")[1].split(":")[0]}:"
                                              "${chats[i]['timestamp'].toDate().toString().split(" ")[1].split(":")[1]}")
                                    ],
                                  ),
                                ],
                              );
                            });
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            TextFormField(
              controller: messageController,
              onChanged: (val) {
                message = val;
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    ChatDetails chatdetails = ChatDetails(
                        receiverUid: receiver.uid,
                        senderUid: Auth_helper
                            .auth_helper.firebaseAuth.currentUser!.uid,
                        message: message!);

                    Firestore_Helper.firestore_helper
                        .sendMessage(chatDetails: chatdetails);
                    log("$message");
                    messageController.clear();
                  },
                  icon: const Icon(Icons.send),
                ),
                hintText: "send message.....",
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
