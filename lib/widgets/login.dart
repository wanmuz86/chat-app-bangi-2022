import 'package:chat_app_bangi/widgets/register.dart';
import 'package:chat_app_bangi/widgets/reset.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'list.dart';
class LoginPage extends StatelessWidget {

  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(hintText: "Enter your email"),
            controller: emailEditingController,),
            SizedBox(height: 8,),
            TextField(
              controller: passwordEditingController,
              decoration: InputDecoration(hintText: "Enter your password"),obscureText: true,),
            TextButton(onPressed: (){

              _auth.signInWithEmailAndPassword(email: emailEditingController.text, password: passwordEditingController.text)
              .then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=>ListPage(email: value.user!.email!,userId: value.user!.uid,)));
              }).catchError((err){
                print(err);
              });



            }, child: Text("Login"),style:
            ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.blueAccent),
            foregroundColor: MaterialStateProperty.all(Colors.white)
            ),
            ),
            TextButton(onPressed: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context)=>RegisterPage()));

            }, child: Text("Don't have an account? Register now")),
            TextButton(onPressed: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context)=>ResetPage()));

            }, child: Text("Reset password")),
          ],
        ),
      )
    );
  }
}
