import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/views/log_in_view.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});
  static String id = "ChatView";
  CollectionReference users =
      FirebaseFirestore.instance.collection(kMessageCollection);
  TextEditingController controller = TextEditingController();
  String text = '';
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: users.orderBy(kTime, descending: true).snapshots(),
      builder: (context, snapshot) {
        List<Message> messageList = [];
        if (snapshot.hasData) {
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromJson(snapshot.data!.docs[i].data()));
            print(snapshot.data!.docs[i].data());
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, LogInView.id);
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ],
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 50,
                    width: 50,
                  ),
                  const Text(" Chat", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            body: Column(
              children: [
                snapshot.hasData
                    ? Expanded(
                        child: ListView.builder(
                          reverse: true,
                          itemCount: messageList.length,
                          itemBuilder: (context, index) {
                            return messageList[index].owner == email
                                ? ChatBubble(
                                    message: messageList[index],
                                  )
                                : ChatBubbleForFriend(
                                    message: messageList[index],
                                  );
                          },
                        ),
                      )
                    : const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {
                      text = value;
                    },
                    onSubmitted: (value) {
                      users.add({
                        kMessage: value,
                        kTime: DateTime.now(),
                        'owner': email
                      });
                      controller.clear();
                      text = '';
                    },
                    decoration: InputDecoration(
                      hintText: "Message",
                      suffixIcon: IconButton(
                        onPressed: () {
                          users.add({
                            kMessage: text,
                            kTime: DateTime.now(),
                            'owner': email
                          });
                          controller.clear();
                          text = '';
                        },
                        icon: const Icon(Icons.send),
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, LogInView.id);
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ],
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 50,
                    width: 50,
                  ),
                  const Text(" Chat", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            body: Column(
              children: [
                const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onChanged: (value) {
                      text = value;
                    },
                    onSubmitted: (value) {
                      users.add({
                        kMessage: value,
                        kTime: DateTime.now(),
                        'owner': email
                      });
                      controller.clear();
                      text = '';
                    },
                    decoration: InputDecoration(
                      hintText: "Message",
                      suffixIcon: IconButton(
                        onPressed: () {
                          users.add({
                            kMessage: text,
                            kTime: DateTime.now(),
                            'owner': email
                          });
                          controller.clear();
                          text = '';
                        },
                        icon: const Icon(Icons.send),
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
