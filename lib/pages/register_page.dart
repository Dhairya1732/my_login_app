import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController1 = TextEditingController();
  final _passwordController2 = TextEditingController();

  bool isVisible = true;

  void toggle() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  void validateEmail() {}

  bool validatePassword() {
    if (_passwordController1.text.trim() == _passwordController2.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future signUp() async {
    if (validatePassword()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController2.text.trim());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController1.dispose();
    _passwordController2.dispose();
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
          const Center(
            child: Text(
              "Welcome to My App",
              style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter an email!";
                        } else if (!RegExp(
                                r"^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$")
                            .hasMatch(value)) {
                          return "Please enter a valid email!";
                        } else {
                          return null;
                        }
                      },
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: "Enter email id",
                        labelText: "Email id",
                        prefixIcon: Icon(Icons.account_circle),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      obscureText: isVisible,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a password!";
                        } else {
                          return null;
                        }
                      },
                      controller: _passwordController1,
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
                              : const Icon(Icons.visibility),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      obscureText: isVisible,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter a password!";
                        } else if (!validatePassword()) {
                          return "Password and Confirm Password should have the same value!";
                        } else {
                          return null;
                        }
                      },
                      controller: _passwordController2,
                      decoration: InputDecoration(
                        errorMaxLines: 3,
                        hintText: "Enter password",
                        labelText: "Confirm Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            toggle();
                          },
                          icon: isVisible
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
              height: 40,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signUp();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 59, 139, 219)),
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
              )),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Registered? ",
                style: TextStyle(color: Colors.black),
              ),
              GestureDetector(
                onTap: widget.showLoginPage,
                child: const Text(
                  "Login Now",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
