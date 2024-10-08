import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/routes.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String name = "";
  bool changeButton = false;
  bool showPassword = false; // Add this variable
  final _formkey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(seconds: 1));

      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.canvasColor,
      child: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Image.asset(
                "assets/images/login.png",
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Welcome $name",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 32.0,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: "Enter username",
                        labelText: "Username",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username cannot be empty";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        labelText: "Email",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email cannot be empty";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        name = value;
                        setState(() {});
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText:
                                !showPassword, // Toggle password visibility
                            decoration: InputDecoration(
                              hintText: "Enter password",
                              labelText: "Password",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              } else if (value.length < 6) {
                                return "Password length should be 6";
                              }
                              return null;
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          child: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    InkWell(
                      onTap: () => _login(),
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        width: changeButton ? 50 : 150,
                        height: 50,
                        alignment: Alignment.center,
                        child: changeButton
                            ? Icon(
                                Icons.done,
                                color: Colors.white,
                              )
                            : Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius:
                              BorderRadius.circular(changeButton ? 50 : 8),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    InkWell(
                      onTap: () => _register(),
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        width: changeButton ? 50 : 150,
                        height: 50,
                        alignment: Alignment.center,
                        child: changeButton
                            ? Icon(
                                Icons.done,
                                color: Colors.white,
                              )
                            : Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius:
                              BorderRadius.circular(changeButton ? 50 : 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? storedUsername = prefs.getString('username');
    String? storedPassword = prefs.getString('password');

    String enteredUsername = _usernameController.text;
    String enteredPassword = _passwordController.text;

    if (enteredUsername == storedUsername &&
        enteredPassword == storedPassword) {
      _showDialog(context, 'Login Successful', 'Welcome, $enteredUsername!');
    } else {
      _showDialog(context, 'Login Failed', 'Invalid username or password.');
    }
  }

  void _register() async {
    String enteredUsername = _usernameController.text;
    String enteredPassword = _passwordController.text;

    if (enteredUsername.isNotEmpty && enteredPassword.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('username', enteredUsername);
      prefs.setString('password', enteredPassword);

      _showDialog(context, 'Registration Successful', 'You can now log in.');
      _usernameController.text = "";
      _passwordController.text = "";
    } else {
      _showDialog(context, 'Registration Failed',
          'Please enter both username and password.');
    }
  }

  void _showDialog(context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
