
import 'package:flutter/material.dart';

class HeadText extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.05),
            const Center(
              child: Text("𝕊𝕟𝕒𝕡𝕊𝕖𝕖𝕜𝕖𝕣", style: TextStyle(
                fontSize: 45,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),),
            ),
            const Image(
              image: NetworkImage('https://www.91-cdn.com/hub/wp-content/uploads/2023/10/Beach.jpg'),
              width: 500, // Adjust the width as needed
              height: 200, // Adjust the height as needed
              // You can also add other properties like fit, alignment, etc.
            ),
          ],
        )
    );

  }
}
