// authentication_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> doesEmailExist(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> result = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      return result.docs.isNotEmpty;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

// create new user
  Future<void> createUserIfNotExist(
      String email, String username, String password) async {
    try {
      bool emailExists = await doesEmailExist(email);
      if (!emailExists) {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        await _firestore.collection('users').doc(email).set({
          'email': email,
          'username': username,
        });
        print('User created and added to Firestore');
      } else {
        print('User with email already exists');
      }
    } catch (e) {
      print('Error creating user: $e');
    }
  }

  // login
  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful!'),
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed. Please check your credentials.'),
          duration: Duration(seconds: 3),
        ),
      );
      print('Error logging in: $e');
    }
  }
}
