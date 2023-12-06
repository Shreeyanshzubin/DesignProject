
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:photo_share_clone_app/log_in/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
    runApp( MyApp());
}

class MyApp extends StatelessWidget {

    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot)
      {
        if(snapshot.connectionState == ConnectionState.waiting)
        {
          return const MaterialApp(
              debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Center(
                  child: Text("Welcome to photo sharing clone app"),
                ),
              ),
            )
          );
        }

        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Flutter Sharing Clone App",
          home: LoginScreen(),
        );

      }

    );
    //  return  MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   title: "Flutter Sharing Clone App",
    //   home: LoginScreen(),
    // );
  }
}



