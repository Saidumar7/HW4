import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'dart:async';

class LocalUsersScreen extends StatefulWidget {
  @override
  _LocalUsersScreenState createState() => _LocalUsersScreenState();
}

class _LocalUsersScreenState extends State<LocalUsersScreen> {
  List<User> localUsers = [];
  DBHelper databaseHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    fetchLocalUsers();
  }

  Future<void> fetchLocalUsers() async {
    List<User> users = await databaseHelper.test_read("user.db");

    setState(() {
      localUsers = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 48, 222, 222),
      appBar: AppBar(
        title: Text('Local Users\' Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Local Users:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: localUsers.length,
                itemBuilder: (context, index) {
                  final user = localUsers[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle:Text(user.address),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
