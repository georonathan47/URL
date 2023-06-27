// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:url_scan/core/constants/progressDialog.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/widgetFuntions.dart';
import '../../../../core/services/api.dart';
import '../pages/Index.dart';

class LoginForm extends StatefulWidget {
  final Color? textColor;

  const LoginForm({super.key, this.textColor});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool haveAgreed = false;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Form(
      key: UniqueKey(),
      child: screenBody(
        context,
        children: [
          addVertical(40),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.275,
              child: Lottie.asset(
                "assets/images/splash.json",
                fit: BoxFit.contain,
              ),
            ),
          ),
          addVertical(deviceSize.height * 0.015),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: addSubTitle(
              context,
              'Login to access your dashboard. Use your Email address and Password to login to your account!',
              fontSize: 16,
            ),
          ),
          addVertical(deviceSize.height * 0.035),
          buildTextField(
            'Enter your email address',
            'eg: testuser@test.com',
            emailController,
          ),
          addVertical(deviceSize.height * 0.025),
          TextFormField(
            obscureText: !showPassword,
            controller: passwordController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock_outline_rounded,
                size: 20,
                color: widget.textColor,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: showPassword == false
                    ? Icon(
                        CupertinoIcons.eye_slash,
                        color: Colors.teal[400],
                      )
                    : Icon(
                        CupertinoIcons.eye_fill,
                        color: Colors.red[400],
                      ),
              ),
              contentPadding: const EdgeInsets.only(left: 15),
              labelText: 'Password',
              hintText: '***********',
              hintStyle: GoogleFonts.raleway(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 2,
                color: widget.textColor,
              ),
              labelStyle: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: .25,
                color: widget.textColor,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black45, width: 0.025),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black45, width: 0.05),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          addVertical(deviceSize.height * 0.010),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: [
                Checkbox(
                  activeColor: successful,
                  value: haveAgreed,
                  onChanged: (value) {
                    setState(() {
                      haveAgreed = value!;
                    });
                  },
                ),
                addHorizontal(deviceSize.width * 0.0005),
                Text(
                  'Remember Me ',
                  style: GoogleFonts.raleway(
                    color: widget.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          addVertical(deviceSize.height * 0.010),
          SizedBox(
            width: deviceSize.width * 0.9,
            height: deviceSize.height * 0.05,
            child: ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (_) => const ProgressDialog(displayMessage: "Verifying..."),
                );
                await Future.delayed(const Duration(seconds: 1));
                Api()
                    .login(
                  emailController.text,
                  passwordController.text,
                  context: context,
                )
                    .then((value) {
                  // if (value.contains(""))

                  print(value);
                  UserCredential userCredentials = value;
                  print(userCredentials.user!.email);
                  if (userCredentials.user != null) {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Index()));
                  } else {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Invalid Credentials',
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
                });
              },
              child: Text(
                'LOGIN',
                style: GoogleFonts.raleway(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1.25,
                ),
              ),
            ),
          ),
          addVertical(deviceSize.height * 0.05),
        ],
      ),
    );
  }
}
