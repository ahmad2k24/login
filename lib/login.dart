import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/home.dart';
import 'package:login/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Track if there's an error and display it
  String? emailError;
  String? passwordError;

  // Validators
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  Future<void> _login() async {
    setState(() {
      // Reset errors
      emailError = emailValidator(emailController.text);
      passwordError = passwordValidator(passwordController.text);
    });

    if (_formKey.currentState!.validate()) {
      try {
        // Attempt to sign up with Firebase
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        // If successful, show success or navigate to another screen
        showCupertinoDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
            title: const Text("Success"),
            content: const Text("Login successful!"),
            actions: [
              CupertinoDialogAction(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                    setState(() {
                      emailController.clear();
                      passwordController.clear();
                    });
                  }),
            ],
          ),
        );
      } on FirebaseAuthException catch (e) {
        // Catch Firebase errors and set appropriate messages
        setState(() {
          if (e.code == 'email-already-in-use') {
            emailError = 'The email is already in use.';
          } else if (e.code == 'weak-password') {
            passwordError = 'The password is too weak.';
          }
        });
      } catch (e) {
        // Handle other errors
        print(e);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Login Page'),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;

          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(isWideScreen ? 16.0 : 32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Email:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: isWideScreen ? 700 : 350,
                        child: CupertinoTextField(
                          controller: emailController,
                          placeholder: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                      if (emailError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            emailError!,
                            style: const TextStyle(
                                color: CupertinoColors.systemRed),
                          ),
                        ),
                      const SizedBox(height: 16),
                      const Text(
                        "Password:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: isWideScreen ? 700 : 350,
                        child: CupertinoTextField(
                          controller: passwordController,
                          placeholder: 'Password',
                          obscureText: true,
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                      if (passwordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            passwordError!,
                            style: const TextStyle(
                                color: CupertinoColors.systemRed),
                          ),
                        ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: isWideScreen ? 700 : 350,
                        child: CupertinoButton.filled(
                          onPressed: _login,
                          child: const Text('Login'),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: isWideScreen ? 700 : 350,
                        child: CupertinoButton(
                          child: const Text('Register'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Register(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
