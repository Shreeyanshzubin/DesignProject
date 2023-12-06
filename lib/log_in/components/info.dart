import 'package:flutter/material.dart';
import 'package:photo_share_clone_app/button.dart';
import 'package:photo_share_clone_app/homeScreen.dart';

class Credentials extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Center(
            child: CircleAvatar(
              radius: 120,
              backgroundImage: AssetImage(
                "images/applogo.png"
              ),
              backgroundColor: Colors.lightBlue.shade800,
            ),
          ),
            ButtonLogin(
              text: "Share",
              colors1: Colors.blue,
              colors2: Colors.blueAccent,

              press: () async{
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
              },
            ),
        ]
      )
    );
  }
}