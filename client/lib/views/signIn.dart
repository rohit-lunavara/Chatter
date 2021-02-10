import 'package:chat_app/views/chatScreen.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:chat_app/src/chatApplication.dart';
import "package:flutter/material.dart";

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  ChatApplication chatApplication = new ChatApplication(null);

  signIn() async {
    if (formKey.currentState.validate()) {
      User existingUser = new User(
          emailTextEditingController.text, passwordTextEditingController.text);
      bool isExistingUser = false;
      try {
        isExistingUser = await chatApplication.signInUser(existingUser);
      } catch (e) {
        showDialogWithMessage(context, e.toString());
        return;
      }

      if (isExistingUser) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ChatScreen(existingUser)));
      } else {
        showDialogWithMessage(
            context, "Invalid Sign In details, please try again!");
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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
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
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    autofocus: true,
                    child: Text("Sign In"),
                  ),
                  SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          "Sign Up",
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                    )
                  ])
                ],
              ),
            ),
          ),
        ));
  }
}
