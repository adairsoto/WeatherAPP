import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:superapp/components/my_button.dart';
import 'package:superapp/components/my_textfield.dart';
import 'package:superapp/pages/registration_page.dart';
import 'package:superapp/pages/weather_page.dart';
import 'package:superapp/services/database_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String? errorMessage = '';

  signUserIn(BuildContext context) async {
    
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      final user = await DatabaseHelper.getUser(usernameController.text);

      if (user.username == usernameController.text &&
          user.password == passwordController.text) {
        Fluttertoast.showToast(msg: 'Logged In!');    
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WeatherPage()));
        reset();
      } else {
        setState(() {
          errorMessage = 'Invalid credentials!';
        });
      }
    } else {
      setState(() {
        errorMessage = 'Invalid credentials!';
      });
    }
  }

  reset() {
    usernameController.text = '';
    passwordController.text = '';
    setState(() {
      errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  const Icon(Icons.lock, size: 100),
                  const SizedBox(height: 50),
                  Text(
                    'Welcome! Let\'s check the weather.',
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),
                  const SizedBox(height: 35),
                  MyTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    errorMessage ?? '',
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  MyButton(
                    onTap: () => signUserIn(context),
                    buttonName: 'Sign In',
                  ),
                  const SizedBox(height: 50),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    child: Text(
                      'Not registered? Click here.',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    onTap: () {
                      reset();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegistrationPage()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
