import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    checkFirstLaunch();
  }

  Future<void> checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('firstLaunch') ?? true;

    if (isFirstLaunch) {
      prefs.setBool('firstLaunch', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 48, 222, 222),
      appBar: AppBar(
        title: Text('Welcome Screen'),
      ),
      body: Center(
        child: Text('Welcome! Tutorial(which we haven\'t) is here.'),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/users');
        },
        child: Center(
        child: Text('Go'),
        heightFactor: 6,
        widthFactor: 6,
      ),
      ),
    );
  }
}
