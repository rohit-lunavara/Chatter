import 'dart:async';

import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/src/chatApplication.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatScreen extends StatefulWidget {
  final User currentUser;
  ChatScreen(this.currentUser);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = new TextEditingController();

  ChatApplication chatApplication;
  Stream chatMessageStream;

  List<Message> chatMessages = [];
  StreamController<Message> chatMessageStreamController;

  sendMessage() async {
    final message = messageController.text;
    if (message.isEmpty) {
      return;
    }

    messageController.text = "";
    try {
      final messageCreated = await chatApplication.createMessage(message);
      if (messageCreated) {
        chatMessages.add(Message(widget.currentUser.email, message));
      }
    } catch (e) {
      showDialogWithMessage(context, e.toString());
      return;
    }

    getMessages();
  }

  getMessages() {
    chatMessageStreamController = StreamController.broadcast();
    chatMessageStreamController.stream
        .listen((message) => setState(() => chatMessages.add(message)));

    chatMessages = [];

    try {
      chatMessageStream = chatApplication.getMessages(context);
      chatMessageStream.pipe(chatMessageStreamController);
    } catch (e) {
      showDialogWithMessage(context, e.toString());
      return;
    }
  }

  @override
  void initState() {
    setState(() {
      chatApplication = new ChatApplication(widget.currentUser);
      getMessages();
    });
    super.initState();
  }

  Widget chatMessageList() {
    return Flexible(
      child: ListView.builder(
        itemCount: chatMessages.length,
        itemBuilder: (context, index) {
          final isCurrentUser =
              chatMessages[index].email == widget.currentUser.email;
          return MessageTile(chatMessages[index].email,
              chatMessages[index].message, isCurrentUser);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Application"),
        actions: [
          Padding(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  getMessages();
                },
                child: Icon(Icons.refresh),
              )),
          Padding(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Authenticate()));
                },
                child: Icon(Icons.logout),
              ))
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              chatMessageList(),
              Container(
                alignment: Alignment.bottomCenter,
                color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(hintText: "Message"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.send),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF)
                            ]),
                            borderRadius: BorderRadius.circular(40)),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String email;
  final String message;
  final bool isCurrentUser;
  MessageTile(this.email, this.message, this.isCurrentUser);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                  colors: isCurrentUser
                      ? [Colors.lightBlue, Colors.lightBlue]
                      : [Colors.lightGreen, Colors.lightGreen])),
          child: Column(
            children: [
              Container(
                alignment: isCurrentUser
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Text(
                  isCurrentUser ? "You" : email,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Container(
                alignment: isCurrentUser
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Text(
                  message,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ));
  }
}
