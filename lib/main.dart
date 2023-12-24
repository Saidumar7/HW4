import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'users_list.dart';
import 'local_users.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HW4',
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/users': (context) => UsersScreen(),
        '/localusers': (context) => LocalUsersScreen(),
      },
    );
  }
}
