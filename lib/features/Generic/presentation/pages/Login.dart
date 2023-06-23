// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_scan/core/constants/colors.dart';
import 'package:url_scan/core/services/api.dart';
import 'package:url_scan/features/Generic/presentation/pages/Index.dart';

import '../../../../core/constants/widgetFuntions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  bool haveAgreed = false;
  bool showPassword = false;
  dynamic removeZero;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final emailFormKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: emailFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.175,
                  child: Image.asset(
                    'assets/images/google.png',
                    fit: BoxFit.contain,
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
                buildTextField2(
                  'Email Address *',
                  'abc@gmail.com',
                  // 'Please enter your email address',
                  false,
                  const Icon(Icons.email),
                  emailController,
                  textColor: textColor,
                  inputDecoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      size: 20,
                      color: textColor,
                    ),
                    contentPadding: const EdgeInsets.only(left: 15),
                    labelText: 'Email Address *',
                    hintText: 'abc@gmail.com',
                    hintStyle: GoogleFonts.raleway(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                      color: textColor,
                    ),
                    labelStyle: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: .25,
                      color: textColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: backgroundColor, width: 0.025),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: backgroundColor, width: 0.05),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                addVertical(deviceSize.height * 0.010),
                Card(
                  child: TextFormField(
                    obscureText: !showPassword,
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 20,
                        color: textColor,
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
                        color: textColor,
                      ),
                      labelStyle: GoogleFonts.raleway(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: .25,
                        color: textColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: backgroundColor, width: 0.025),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: backgroundColor, width: 0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                addVertical(deviceSize.height * 0.010),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      Api().signUp(emailController.text, passwordController.text);
                      Api().login(emailController.text, passwordController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Index(),
                        ),
                      );
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
                // Center(
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => const Register(),
                //         ),
                //       );
                //     },
                //     child: RichText(
                //       text: TextSpan(
                //         text: 'Don\'t have an account? ',
                //         style: GoogleFonts.raleway(
                //           fontWeight: FontWeight.w400,
                //           color: textColor,
                //           fontSize: 18,
                //         ),
                //         children: [
                //           TextSpan(
                //             text: 'Register Here...',
                //             style: GoogleFonts.raleway(
                //               fontWeight: FontWeight.w700,
                //               color: isDarkMode == true ? Colors.white : PRIMARY_COLOR,
                //               fontSize: 18,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
