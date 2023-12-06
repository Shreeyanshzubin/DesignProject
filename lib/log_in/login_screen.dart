import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:photo_share_clone_app/log_in/components/heading_text.dart';
import 'package:photo_share_clone_app/log_in/components/info.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.blue.shade300],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.2, 0.9],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // const SizedBox(
                //   height: 150, // Adjust the height as needed
                //   child: Image(
                //     image: NetworkImage('https://www.91-cdn.com/hub/wp-content/uploads/2023/10/Beach.jpg'),
                //     width: 700, // Adjust the width as needed
                //     height: 200, // Adjust the height as needed
                //     // You can also add other properties like fit, alignment, etc.
                //   ),
                // ),
                HeadText(),
                Credentials(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}







