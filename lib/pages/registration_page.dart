import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:superapp/components/my_button.dart';
import 'package:superapp/components/my_textfield.dart';
import 'package:superapp/models/user_model.dart';
import 'package:superapp/services/database_helper.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  String? errorMessage = '';

  registerUser(BuildContext context) {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      final user = User(username: usernameController.text, password: passwordController.text);

      DatabaseHelper.addUser(user);

      Fluttertoast.showToast(msg: 'User Registered!');

      Navigator.of(context).pop();

      usernameController.text = '';
      passwordController.text = '';   
    } else {
      setState(() {
        errorMessage = 'Both fields are required!';
      });
    }
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
                  const Icon(Icons.person, size: 100),
                  const SizedBox(height: 50),
                  Text(
                    'New User Registration',
                    style: TextStyle(color: Colors.grey[700], fontSize: 18),
                  ),
                  const SizedBox(height: 25),
                  
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
                    onTap: () => registerUser(context),
                    buttonName: 'Register',
                  ),
                  const SizedBox(height: 50),
              
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Divider(thickness: 1,),
                  ),
              
                  const SizedBox(height: 30),
              
                  GestureDetector(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )  
                ],
              ),
            ),
          ),
        ));
  }
}
