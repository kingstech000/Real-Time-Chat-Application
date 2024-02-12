// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, avoid_print, await_only_futures, use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  User? loggedinUser;
  final _firestore = FirebaseFirestore.instance;
  String messageText = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      loggedinUser = user;
      print(loggedinUser!.email);
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   try {
  //     final myMessages = await _firestore.collection('messages').get();
  //     for (var message in myMessages.docs) {
  //       print(message.data());
  //     }
  //   } catch (e) {
  //     print("The reason for the exception is: $e");
  //   }
  // }

  // void getMessageStream() async {
  //   try {
  //     await for (var snapshot
  //         in _firestore.collection('messages').snapshots()) {
  //       for (var message in snapshot.docs) {
  //         print(message.data());
  //       }
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
                stream: _firestore.collection('messages').snapshots(),
                builder: (context, snapshot) {
                  List<Widget> messageBubbles = [];
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else {
                    final messages = snapshot.data?.docs.reversed;
                    for (var message in messages!) {
                      final messageText = message['text'];
                      final messageSender = message['sender'];

                      final currentUser = loggedinUser!.email;

                      final bubbleWidget = MessageBubble(
                        sender: messageSender,
                        text: messageText,
                        isMe: currentUser == messageSender,
                      );
                      messageBubbles.add(bubbleWidget);
                    }
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      padding: EdgeInsetsDirectional.symmetric(
                          horizontal: 10, vertical: 15),
                      children: messageBubbles,
                    ),
                  );
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      style: TextStyle(color: Colors.white),
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      messageTextController.clear();
                      try {
                        print("Process Started");
                        await _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': loggedinUser!.email,
                        });
                        print("Successful send to database");
                      } catch (e) {
                        print("This is the reason for the failure: $e");
                      }
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  String sender;
  String text;
  bool isMe;
  MessageBubble(
      {super.key,
      required this.sender,
      required this.text,
      required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          Material(
              elevation: 5,
              color: isMe ? Colors.lightBlueAccent : Colors.white,
              borderRadius: isMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))
                  : BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  text,
                  style: TextStyle(
                    color: isMe ? Colors.white : Colors.black54,
                    fontSize: 15,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
