import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Center(
            child: Column(
          children: [
            const Text("Home Page"),
            SizedBox(
                height: 40,
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 59, 139, 219)),
                  child: const Text(
                    "Log out",
                  ),
                )),
          ],
        )),
      ),
    );
  }
}
