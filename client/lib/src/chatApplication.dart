import 'dart:core';
import 'dart:io';

import 'package:chat_app/src/generated/chatApplication.pbjson.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

import 'generated/chatApplication.pb.dart';
import 'generated/chatApplication.pbgrpc.dart';

class ChatApplication {
  ChatApplicationClient stub;
  User currentUser;

  ChatApplication(User user) {
    // final trustedRoot = rootBundle.loadString("assets/security/server.crt");
    // final channelCredentials =
    //     new ChannelCredentials.secure(certificates: trustedRoot);
    // final channelOptions = new ChannelOptions(credentials: channelCredentials);
    // final channel = new ClientChannel("localhost", options: channelOptions);
    final channelOptions =
        const ChannelOptions(credentials: const ChannelCredentials.insecure());
    final channel =
        new ClientChannel("localhost", port: 50101, options: channelOptions);
    stub = new ChatApplicationClient(channel);
    currentUser = user;
  }

  Future<bool> signUpUser(User user) async {
    CreateUserResponse createUserResponse = await stub
        .createUser(UserRequest(email: user.email, password: user.password))
        .catchError((e) {
      throw Exception("No connection!");
    });
    return createUserResponse.isCreated;
  }

  Future<bool> signInUser(User user) async {
    VerifyCredentialsResponse verifyCredentialsResponse = await stub
        .verifyCredentials(
            UserRequest(email: user.email, password: user.password))
        .catchError((e) {
      throw Exception("No connection!");
    });
    if (verifyCredentialsResponse.isValid) {
      currentUser = user;
    } else {
      currentUser = null;
    }
    return verifyCredentialsResponse.isValid;
  }

  Future<bool> createMessage(String message) async {
    if (currentUser == null) {
      return false;
    }
    CreateMessageResponse createMessageResponse = await stub
        .createMessage(CreateMessageRequest(
            user: UserRequest(
                email: currentUser.email, password: currentUser.password),
            message: message))
        .catchError((e) {
      throw Exception("No connection!");
    });
    return createMessageResponse.isCreated;
  }

  Stream<Message> getMessages(BuildContext context) async* {
    if (currentUser == null) {
      return;
    }
    ResponseStream<MessageResponse> messages;
    try {
      messages = stub.getMessages(UserRequest(
          email: currentUser.email, password: currentUser.password));
      await for (var message in messages) {
        Message localMessage = new Message(message.email, message.message);
        yield localMessage;
      }
    } catch (e) {
      // TODO: Fix exception handling oddity
      showDialogWithMessage(context, "Exception: No connection!");
    }
  }
}

class User {
  String email;
  String password;

  User(String email, String password) {
    this.email = email;
    this.password = password;
  }

  User.fromUser(User user)
      : email = user.email,
        password = user.password;
}

class Message {
  String email;
  String message;

  Message(String email, String message) {
    this.email = email;
    this.message = message;
  }
}
