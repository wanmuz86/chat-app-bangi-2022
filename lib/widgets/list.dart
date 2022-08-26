import 'package:chat_app_bangi/widgets/detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  final String email;
  final String userId;
  ListPage({required this.email, required this.userId});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // List of Map

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // What is your source of data?
        stream:FirebaseFirestore.instance.collection('users').snapshots(),
        // What to show once you get the data
        builder: (context,snapshot){
          if (!snapshot.hasData){
            return CircularProgressIndicator();
          }else {
// Retrieve the data from firebase
            final List<DocumentSnapshot> employees = snapshot.requireData.docs;
            return ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  return Card(
                    child:
                    widget.email != employees[index]["email"] ?
                    ListTile(
                      title: Text(employees[index]["email"]!),
                      subtitle: Text(employees[index]["department"]!),
                      trailing: Icon(Icons.chevron_right),
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>DetailPage(userId: widget.userId,friendId: employees[index]["id"],)));
                      },
                    ) : SizedBox(),
                  );
                });
          }

        },
    )
    );
  }
}
