import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn() async {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  bool isVisible = true;

  void toggle() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   "assets/images/GdscLogo.png",
          //   scale: 0.8,
          // ),
          const Center(
            child: Text("Welcome to My App",
                style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    hintText: "Enter email id",
                    labelText: "Email id",
                    prefixIcon: Icon(Icons.account_circle))),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                  obscureText: isVisible,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: "Enter password",
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: () {
                            toggle();
                          },
                          icon: isVisible
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility))))),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
              height: 40,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  signIn();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 59, 139, 219)),
                child: const Text(
                  "Log in",
                ),
              )),
        ],
      ),
    );
  }
}
