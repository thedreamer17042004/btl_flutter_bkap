
import 'dart:convert';

import 'package:ecommerce_sem4/components/controls/input_component.dart';
import 'package:ecommerce_sem4/models/user/auth/request/register_request.dart';
import 'package:ecommerce_sem4/route/user/router_constants.dart';
import 'package:ecommerce_sem4/screens/user/auth/views/login_screen.dart';
import 'package:ecommerce_sem4/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class SignUpForm extends StatefulWidget {

  const SignUpForm({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm>{
  String uri = registerUri;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    if (!passwordRegExp.hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character.';
    }
    return null;
  }
  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  Future<void>  _submitForm(BuildContext context) async{
    String email = _emailController.text;
    String password = _passwordController.text;
    String username = _usernameController.text;
    Map<String, Object?> request = RegisterRequest(email, password,username).toMap();
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if(_formKey.currentState!.validate()){
      try {
        http.Response response = await http.post(
          Uri.parse(uri),
          headers: headers,
          body: jsonEncode(request),
        );

        // Check if the response is valid JSON
        if (response.statusCode == 200) {
          try {
            var data = jsonDecode(utf8.decode(response.bodyBytes));

            // Handle success
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Successful")),
            );

            Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginScreen())
              );
          } catch (e) {

            print("Response: ${response.body}");
          }
        } else {

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error in server")),
          );
        }
      } catch (e) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Network error")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        children: [
           InputComponent(text: "Username", placeholder: "Enter Name", controller:_usernameController , validator: usernameValidator,),
          const SizedBox(height: 15,),
           InputComponent(text: "Email", placeholder: "Enter Email", controller: _emailController, validator: emailValidator,),
          const SizedBox(height: 15.0,),
           InputComponent(text: "Password", placeholder: "Password", controller: _passwordController, validator: passwordValidator,),

          const SizedBox(height: 40.0,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius:  BorderRadius.circular(10)
                  ),
                  foregroundColor: f4f4Color,
                  backgroundColor: greenBgColor,
                  minimumSize: const Size.fromHeight(50)),
              onPressed: (){_submitForm(context);},
              child: const Text(' Sign Up ',style: TextStyle(color: f4f4Color, fontSize: 15),)),
          const SizedBox(height: 10,),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                 const TextSpan(
                    text: 'Don’t have account ? ',
                    style: TextStyle(
                      fontSize: 12,
                      color: greyColor,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  TextSpan(
                      text: 'Sign In',
                      style: const TextStyle(
                          fontSize: 12,
                          color: greenBgColor,
                          fontFamily: 'Poppins'
                      ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navigate to a new screen
                        Navigator.pushNamed(
                            context,
                            logInScreenRoute
                        );
                      },
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }
}