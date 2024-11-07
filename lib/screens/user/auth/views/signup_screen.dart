
import 'package:ecommerce_sem4/screens/user/auth/views/components/sign_up_form.dart';
import 'package:ecommerce_sem4/utils/constants.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height
                ),
                child: Container(
                  color: greenBgColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isKeyboardVisible
                          ? Container()
                          : const SizedBox(
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 50),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: whiteColor,
                                      fontSize: 24,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Opacity(
                                    opacity: 0.7,
                                    child: Text(
                                      'To Get more advantages signup you account by filling in \n some information',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 13,
                                          color: whiteColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 60.0),
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: const SignUpForm()),
                    ],
                  ),
                ),
              ),
            )
        )
    );
  }
}