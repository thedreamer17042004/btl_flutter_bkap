
import 'dart:convert';

import 'package:ecommerce_sem4/models/user/post-category/response/post_category_model.dart';

class Account {
  String? id;
  String? avatar;
  String? email;
  String? userName;
  String? address;
  String? gender;
  String? phoneNumber;
  DateTime? createdAt;

  Account({
     this.id,
     this.avatar,
     this.email,
     this.userName,
    this.address,
    this.gender,
    this.phoneNumber,
    this.createdAt
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      avatar: json['content'],
      email: json['postId'],
      userName: json['userName'],
      address:json['address'],
      gender:json['gender'],
      phoneNumber: json['phoneNumber'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
