import 'package:chat_app_bangi/widgets/detail.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  // List of Map
  var employees = [
    {"name": "Muzaffar", "department": "Admin"},
    {"name": "Saiful", "department": "I.T"},
    {"name": "Amira", "department": "Marketing"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
      ),
      body: ListView.builder(
          itemCount: employees.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(employees[index]["name"]!),
                subtitle: Text(employees[index]["department"]!),
                trailing: Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>DetailPage()));
                },
              ),
            );
          }),
    );
  }
}
