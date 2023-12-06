import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ButtonLogin extends StatelessWidget {

  final String text;
  final VoidCallback press;
  final Color colors1;
  final Color colors2;

  ButtonLogin({
    required this.text,
    required this.press,
    required this.colors1,
    required this.colors2,
});

       @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0, bottom: 6.0),
        child: Container(
          width: double.infinity,
          height: 66,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blueAccent,
                Colors.blue
              ]
            ),
              boxShadow: const [
                BoxShadow(
              offset: Offset(1,1),
              spreadRadius: 1,
              blurRadius: 1,
             color: Colors.blue,
          ),
          BoxShadow(
            offset: Offset(1,1),
            spreadRadius: 1,
            blurRadius: 1,
            color: Colors.blueAccent,
          ),
              ]
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}