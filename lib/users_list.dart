import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'database_helper.dart';
import 'dart:async';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<Map<String, dynamic>> userList = [];
  DBHelper databaseHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=5'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> results = data['results'];

      setState(() {
        userList = results.cast<Map<String, dynamic>>();
      });
    } else {
      print('Failed. Status code: ${response.statusCode}');
    }
  }

  Future<void> fetchMoreUsers() async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=5'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> results = data['results'];

      setState(() {
        userList.addAll(results.cast<Map<String, dynamic>>());
      });
    } else {
      print('Failed. Status code: ${response.statusCode}');
    }
  }

  Future<void> storeSelectedUser(Map<String, dynamic> selectedUser) async {
    int result = await databaseHelper.saveSelectedUser(selectedUser);

    if (result != -1) {
      print('User stored in the local database!');
    } else {
      print('Failed to store user in the local database.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 48, 222, 222),
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Users:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  final user = userList[index];
                  return ListTile(
                    title: Text(user['name']['first'] ?? ''),
                    subtitle: Text(user['address'] ?? ''),
                    onTap: () {
                      storeSelectedUser(user);
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    fetchMoreUsers();
                  },
                  child: Text('Fetch More Users'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/localusers');
                  },
                  child: Text('Second Button'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
