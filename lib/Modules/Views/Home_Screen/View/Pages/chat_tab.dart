import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Helpers/Authentication_Helper/auth_helper.dart';
import '../../../../Helpers/Cloud_firestore_helper/firestore_helper.dart';
import '../../../../Stream/stream.dart';
import '../../../Chat_Screen/Model/chat_model.dart';
import '../../../Chat_Screen/Model/receiver_model.dart';
import '../../controller/Image_picker_controller.dart';

class chats extends StatelessWidget {
  chats({super.key});

  ImagePicker picker = ImagePicker();

  ImagePickerController controller = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            (Auth_helper.auth_helper.firebaseAuth.currentUser?.photoURL == null)
                ? GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                          title: "Choose Image From...",
                          content: Container(
                            height: 100,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GetBuilder<ImagePickerController>(
                                  builder: (controller) => IconButton(
                                      onPressed: () async {
                                        XFile? photo = await picker.pickImage(
                                            source: ImageSource.camera);

                                        controller.pickImage(
                                            pickedImage: File(photo!.path));
                                        Get.back();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt_outlined,
                                        size: 35,
                                      )),
                                ),
                                GetBuilder<ImagePickerController>(
                                  builder: (controller) => IconButton(
                                      onPressed: () async {
                                        XFile? photo = await picker.pickImage(
                                            source: ImageSource.gallery);

                                        controller.pickImage(
                                            pickedImage: File(photo!.path));
                                        log("${controller.imagePickerModel.image?.path}");
                                        Get.back();
                                      },
                                      icon: Icon(
                                        Icons.photo,
                                        size: 35,
                                      )),
                                )
                              ],
                            ),
                          ));
                    },
                    child: (controller.imagePickerModel.image == null)
                        ? CircleAvatar(
                            radius: 80,
                            foregroundImage: NetworkImage(
                                "https://xsgames.co/randomusers/assets/images/favicon.png"),
                          )
                        : GetBuilder<ImagePickerController>(
                            builder: (_) => CircleAvatar(
                              radius: 80,
                              foregroundImage:
                                  FileImage(controller.imagePickerModel.image!),
                            ),
                          ))
                : CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.orange,
                    child: CircleAvatar(
                      radius: 85,
                      foregroundImage: NetworkImage(
                          "${Auth_helper.auth_helper.firebaseAuth.currentUser?.photoURL}"),
                    ),
                  ),
            const Divider(),
            (Auth_helper.auth_helper.firebaseAuth.currentUser?.displayName ==
                    null)
                ? (Auth_helper.auth_helper.firebaseAuth.currentUser?.email ==
                        null)
                    ? Text("NAME: John Doe")
                    : Text(
                        "NAME: ${Auth_helper.auth_helper.firebaseAuth.currentUser?.email?.split("@")[0]}")
                : Text(
                    "NAME: ${Auth_helper.auth_helper.firebaseAuth.currentUser?.displayName}"),
            const Divider(),
            (Auth_helper.auth_helper.firebaseAuth.currentUser?.email == null)
                ? Text("EMAIL: JohnDoe@gmail.com")
                : Text(
                    "EMAIL: ${Auth_helper.auth_helper.firebaseAuth.currentUser?.email}"),
            const Divider(),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          // IconButton(
          //     onPressed: () {
          //       Get.toNamed('/notification');
          //     },
          //     icon: Icon(Icons.notifications_outlined)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Auth_helper.auth_helper.signOut();

                  Get.offNamedUntil('/', (route) => false);
                },
                icon: const Icon(Icons.logout_outlined)),
          )
        ],
        title: (Auth_helper.auth_helper.firebaseAuth.currentUser?.displayName ==
                null)
            ? (Auth_helper.auth_helper.firebaseAuth.currentUser?.email == null)
                ? Text("John Doe")
                : Text(
                    "${Auth_helper.auth_helper.firebaseAuth.currentUser?.email?.split("@")[0]}")
            : Text(
                "${Auth_helper.auth_helper.firebaseAuth.currentUser?.displayName}"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Firestore_Helper.firestore_helper.fetchUser(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? userData =
                querySnapshot?.docs;

            return ListView.builder(
                itemCount: userData?.length,
                itemBuilder: (ctx, i) {
                  return Card(
                      elevation: 3,
                      child: ListTile(
                        onTap: () async {
                          Receiver receiver = Receiver(
                              name: userData?[i]['name'],
                              uid: userData?[i]['uid'],
                              photo: userData?[i]['photo']);

                          ChatDetails chatdata = ChatDetails(
                              receiverUid: receiver.uid,
                              senderUid: Auth_helper
                                  .auth_helper.firebaseAuth.currentUser!.uid,
                              message: "");
                          messageData = await Firestore_Helper.firestore_helper
                              .displayMessage(chatDetails: chatdata);
                          Get.toNamed("/chat", arguments: receiver);
                        },
                        title: Text("${userData?[i]['name']}"),
                        subtitle: Text("${userData?[i]['email']}"),
                        leading: CircleAvatar(
                          radius: 30,
                          foregroundImage:
                              NetworkImage("${userData?[i]['photo']}"),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Firestore_Helper.firestore_helper.deleteUser(
                                deleteData: "${userData?[i]['uid']}");
                          },
                          icon: Icon(Icons.delete_outline),
                        ),
                      ));
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
