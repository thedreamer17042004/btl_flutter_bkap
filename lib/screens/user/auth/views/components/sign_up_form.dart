
import 'package:ecommerce_sem4/components/controls/input_component.dart';
import 'package:ecommerce_sem4/route/user/router_constants.dart';
import 'package:ecommerce_sem4/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
    return null;
  }
  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void _submitForm() {

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
              onPressed: _submitForm,
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