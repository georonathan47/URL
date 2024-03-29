// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

const String api_key = "LSMufeuYohAku8Nzgfevu53sxA8bAkrV";
const String api_url = "https://ipqualityscore.com/api/json/url/$api_key";

class Api {
  scan(String url) async {
    final response = await http.get(Uri.parse('$api_url/$url'));
    if (response.statusCode == 200) {
      print('Api Url: $api_url/$url');
      print('Response body: ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  signUp(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  login(String email, String password, {required BuildContext context}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'No user found for the provided email.',
              style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: .25,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red[400],
          ),
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'The provided password is incorrect!',
              style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: .25,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red[400],
          ),
        );
      } else  if (e.code == 'network-request-failed') {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Please check your internet connection!',
              style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: .25,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red[400],
          ),
        );

      }
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
