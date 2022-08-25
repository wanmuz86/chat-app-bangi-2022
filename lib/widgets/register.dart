import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
 var emailEditingController = TextEditingController();
 var passwordEditingController = TextEditingController();

 FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(hintText: "Enter your email"),
            controller: emailEditingController,
            ),
            TextField(decoration: InputDecoration(hintText: "Enter your password"),
            obscureText: true,
            controller:passwordEditingController,
            ),
            TextButton(onPressed: (){
              _auth.createUserWithEmailAndPassword(email: emailEditingController.text,
                  password: passwordEditingController.text)
                  .then((value) {
                final snackBar = SnackBar(
                  content: const Text('Succesfully registered, you may login now'),

                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              }).catchError((onError){

                final snackBar = SnackBar(
                  content:  Text(onError.message!),

                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);

              });
            }, child: Text("Register"))
          ],
        ),
      ),
    );
  }
}
