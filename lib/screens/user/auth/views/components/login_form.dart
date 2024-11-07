import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import 'package:ecommerce_sem4/components/controls/input_component.dart';
import 'package:ecommerce_sem4/models/user/auth/request/login_request.dart';
import 'package:ecommerce_sem4/models/user/auth/response/account_infor.dart';
import 'package:ecommerce_sem4/route/user/router_constants.dart';
import 'package:ecommerce_sem4/screens/user/home/views/home_screen.dart';
import 'package:ecommerce_sem4/screens/user/layout/views/layout_screen.dart';
import 'package:ecommerce_sem4/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>{
  String uri = loginUri;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  void _submitForm() {
    String email = _emailController.text;
    String password = _passwordController.text;

    Map<String, Object?> request = LoginRequest(email, password).toMap();
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    if(_formKey.currentState!.validate()){
      http.post(
        Uri.parse(uri),
        headers: headers,
        body: jsonEncode(request),
      ).then((value)  async{
        var data = jsonDecode(const Utf8Decoder().convert(value.bodyBytes));
        print(request);
        print(data);

        if(data['token']==null){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Thông báo lỗi'),
                  content: Text("Email or password is not correct"),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Đóng'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        }else {
          //lay token then giai ma de lay thong tin
          //set vao preference
          final jwt = JWT.decode(data['token']);
          Map<String,Object?> result = {
            "email":jwt.payload["email"],
            "sub": jwt.payload["sub"],
            "role":jwt.payload["role"],
            "accessToken": data['token'],
            "exp":jwt.payload["exp"],
            "id": jwt.payload["Id"]
          };
          var acc = AccountInfor.fromJson(result);
          var prefs = await SharedPreferences.getInstance();

          prefs.setString("email", acc.email);
          prefs.setString("sub", acc.sub);
          prefs.setString("role", acc.role);
          prefs.setInt("exp", acc.exp.microsecondsSinceEpoch);
          prefs.setString("accessToken", acc.accessToken);
          prefs.setString("id", acc.id);

          if (!context.mounted) return;

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const LayoutScreen())
          );
        }

      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputComponent(text: "Email", placeholder: "Enter Email",controller: _emailController,validator: emailValidator,),
         const SizedBox(height: 15,),
           InputComponent(text: "Password", placeholder: "Password", controller: _passwordController,validator: passwordValidator,),
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
              child: const Text(' Sign In ',style: TextStyle(color: f4f4Color, fontSize: 15),)
          ),
        const SizedBox(height: 10,),
          RichText(
            text: TextSpan(
                children: <TextSpan>[
                 const TextSpan(
                    text: 'Don’t have account ? ',
                    style:  TextStyle(
                      fontSize: 12,
                      color: greyColor,
                      fontFamily: 'Poppins',
                    ),
                  ),
                   TextSpan(
                      text: 'Create account',
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
                             signUpScreenRoute
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