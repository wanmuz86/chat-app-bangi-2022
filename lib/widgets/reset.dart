import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPage extends StatelessWidget {
  var emailEditingController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reset password"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(hintText: "Enter your email"),
              controller: emailEditingController,),
            TextButton(onPressed: (){
              _auth.sendPasswordResetEmail(email: emailEditingController.text).then((value)
              {
                final snackBar = SnackBar(
                  content: const Text('Email succesfully sent, please check your email!'),

                );

                // Find the ScaffoldMessenger in the widget tree
                // and use it to show a SnackBar.
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              }).catchError((err){
                print(err);
              });

            }, child: Text("Reset password"))
          ],
        ),
      ),
    );
  }
}
