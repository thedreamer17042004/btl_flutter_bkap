import 'dart:ui';

import 'package:flutter/material.dart';

// Color
const Color greyColor = Color(0xFF7C7C7C);
const Color greenBgColor = Color(0xFF019934);
const Color whiteColor = Colors.white;
const Color blackColor = Colors.black;
const Color dashedLine = Color(0xFF8E8E8E);
const Color borderInput = Color(0xFF8E8E8E);
const Color f4f4Color = Color(0xFFF4F4F4);
const Color filterProductColor = Color(0xFFF2F3F2);

// uri
const String apiUri = "http://10.0.2.2:5069/api";
const String loginUri = "$apiUri/auth/login";
const String registerUri = "$apiUri/auth/register";
// category
const String categorySearchUri = "$apiUri/category/search";
const String categoryDetailUri = "$apiUri/category";
// product
const String productSearchUri = "$apiUri/product/search";
const String productDetailUri = "$apiUri/product";
// cart
const String cartAddUri = "$apiUri/cart/add";
const String getCartUri = "$apiUri/cart/search";
const String updateQuantityUri = "$apiUri/cart/update";
const String getCartByUserIdUri = "$apiUri/cart/getCart";
const String removeCartUri = "$apiUri/cart";



