import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lab_7/users_model.dart'; // Import your User model classes here

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final String url_ = 'https://randomuser.me/api/?results=34';
  Users users = Users(results: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The list, innit?'),
        backgroundColor: const Color.fromARGB(255, 137, 114, 106),
      ),
      body: ListView.builder(
        itemCount: users.results.length,
        itemBuilder: (context, index) {
          final Result user = users.results[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.picture.thumbnail),
            ),
            title: Text('${user.name.first} ${user.name.last}'),
            subtitle: Text(user.email),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetch,
        child: Icon(Icons.account_circle),
      ),
    );
  }

  void fetch() async {
    final response = await http.get(Uri.parse(url_));

    if (response.statusCode == 200) {
      final json_data = jsonDecode(response.body);
      final List<dynamic> results = json_data['results'];

      final List<Result> converted = results.map((user) {
        return Result(
          gender: user['gender'],
          name: Name(
            title: user['name']['title'],
            first: user['name']['first'],
            last: user['name']['last'],
          ),
          email: user['email'],
          phone: user['phone'],
          picture: Picture(
            thumbnail: user['picture']['thumbnail'],
          
          ),
        );
      }).toList();

      setState(() {
        users = Users(results: converted);
      });
    }
  }
}
