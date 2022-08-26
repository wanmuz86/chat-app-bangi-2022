import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {

  final String userId;
  final String friendId;
  DetailPage({required this.userId, required this.friendId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  var messages = [

  ];
  var messageEditingController = TextEditingController();
  var groupChatId = "";

  @override
  Widget build(BuildContext context) {
    if (widget.userId.hashCode < widget.friendId.hashCode){
      groupChatId = '${widget.userId}-${widget.friendId}';
    }else {
      groupChatId = '${widget.friendId}-${widget.userId}';
    }
    return Scaffold(
      appBar: AppBar(title: Text("Chat"),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
           Expanded(
             child: StreamBuilder<QuerySnapshot>(
               stream: FirebaseFirestore.instance.collection('chats').doc(groupChatId)
               .collection(groupChatId).snapshots(),
               builder: (context,snapshot){
                 if (!snapshot.hasData){
                   return CircularProgressIndicator();
                 }
                 else {
                   var messages = snapshot.requireData.docs;
                   return
                     ListView.builder(
                         itemCount: messages.length,
                         itemBuilder: (context,index){
                           return Card(
                             child: ListTile(
                               title: Text(messages[index]["message"]!),
                               subtitle: Text("${messages[index]["fromId"]!} "
                                   "- ${messages[index]["timestamp"]!}"),
                             ),
                           );
                         });
                 }
               },

             )
           ),
            Row(
              children: [
                Expanded(child: TextField(
                  controller: messageEditingController,
                  decoration: InputDecoration(hintText: "Enter message"),)),
                TextButton(
                  onPressed: (){


                    FirebaseFirestore.instance.collection('chats').doc(groupChatId)
                    .collection(groupChatId).doc(DateTime.now()
                        .microsecondsSinceEpoch.toString()).set({
                      'fromId':widget.userId,
                      'toId':widget.friendId,
                      'message':messageEditingController.text,
                      'timestamp':DateTime.now().microsecondsSinceEpoch.toString()
                    });


                  }, child: Text("Send"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue), foregroundColor: MaterialStateProperty.all(Colors.white)),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
