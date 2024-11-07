

import 'package:ecommerce_sem4/route/user/router_constants.dart';
import 'package:ecommerce_sem4/screens/user/account/views/components/item_component.dart';
import 'package:ecommerce_sem4/services/user/auth/auth_service.dart';
import 'package:ecommerce_sem4/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AccountScreen extends StatelessWidget{
  const AccountScreen({super.key});

  void logout(BuildContext context) {
    AuthService().logout();
    Navigator.pushReplacementNamed(context, onboardingScreenRoute);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AuthService().checkLoginStatus(context);
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: greenBgColor,
          title: const Text(
            "Profile",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Color(0xFFF4F4F4),
            padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
            child: Column(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child:  Container(
                          alignment: Alignment.center,
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: AssetImage("assets/user/images/avatar.png")
                              )
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        "Admin",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "admin@gmail.com",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w300
                        ),

                      ),
                      SizedBox(height: 40,),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                        decoration: BoxDecoration(
                          color: Color(0xFFC2E3CD),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10.0), bottomLeft: Radius.circular(10.0)),

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                IconButton(onPressed: (){}, icon: Icon(Icons.shop)),
                                Text("Orders",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(onPressed: (){}, icon: Icon(Icons.payment)),
                                Text("Payments",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                IconButton(onPressed: (){}, icon: Icon(Icons.location_city)),
                                Text("Address",
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],

                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  child: Column(
                    children: [
                      ItemComponent(text: "User Details", iconButton: const Icon(Icons.account_circle), event: (){}),
                      const SizedBox(height: 15,),
                      ItemComponent(text: "Settings", iconButton:const Icon(Icons.settings), event: (){}),
                      const  SizedBox(height: 15,),
                      ItemComponent(text: "Help && Support", iconButton: const Icon(Icons.question_mark), event: (){}),
                      const  SizedBox(height: 15,),
                      ItemComponent(text: "Change Language", iconButton:const Icon(Icons.language), event: (){}),
                      const  SizedBox(height: 15,),
                      ItemComponent(text: "Logout", iconButton:const Icon(Icons.logout), event: ()=> logout(context)),
                    ],

                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}