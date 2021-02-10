import 'package:chat_app/src/chatApplication.dart';
import 'package:chat_app/views/chatScreen.dart';
import "package:flutter/material.dart";

import '../widgets/widget.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  ChatApplication chatApplication = new ChatApplication(null);

  signUp() async {
    if (formKey.currentState.validate()) {
      User newUser = new User(
          emailTextEditingController.text, passwordTextEditingController.text);
      bool isNewUser = false;
      try {
        isNewUser = await chatApplication.signUpUser(newUser);
      } catch (e) {
        showDialogWithMessage(context, e.toString());
        return;
      }
      if (isNewUser) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ChatScreen(newUser)));
      } else {
        showDialogWithMessage(
            context, "Invalid Sign Up details, please try a different email!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat Application")),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Column(
                children: [
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              // TODO :
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                  .hasMatch(value)) {
                                return "Please provide a valid email address";
                              } else {
                                return null;
                              }
                            },
                            controller: emailTextEditingController,
                            decoration: InputDecoration(hintText: "Email"),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormField(
                              validator: (value) {
                                if (value.isEmpty || value.length < 8) {
                                  return "Please provide a password which is at least 8 characters long";
                                } else {
                                  return null;
                                }
                              },
                              controller: passwordTextEditingController,
                              decoration: InputDecoration(hintText: "Password"),
                              autocorrect: false,
                              obscureText: true),
                          // TODO - Check if both password fields match
                          // TextFormField(
                          //   controller: passwordTextEditingController,
                          //   decoration:
                          //       InputDecoration(hintText: "Repeat Password"),
                          //   autocorrect: false,
                          // ),
                        ],
                      ))
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  signUp();
                },
                autofocus: true,
                child: Text("Sign Up"),
              ),
              SizedBox(height: 8),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    widget.toggle();
                  },
                  child: Container(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      "Sign In",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}
