import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String phone;
  final String email;
  final String password;

  const User(
      {required this.name,
      required this.phone,
      required this.email,
      required this.password});

  factory User.fromDocument(DocumentSnapshot document) {
    return User(
        name: document['name'],
        phone: document['phone'],
        email: document['email'],
        password: document["password"]);
  }
}
