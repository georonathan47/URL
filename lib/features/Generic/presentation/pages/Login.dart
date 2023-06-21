// ignore_for_file: use_build_context_synchronously

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/widgetFuntions.dart';
import '../../../Generic/presentation/pages/Index.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool showPassword = false;
  Credentials? _credentials;

  late Auth0 auth0;

  get primaryColor => Colors.blueAccent;
  @override
  void initState() {
    super.initState();
    auth0 = Auth0('dev-8szuc4zu.us.auth0.com', 'i8WxlhqpqRSbjVWlliOExzvVzIqYZq23');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF3F3F3),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Container(
              decoration: const BoxDecoration(),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  addVertical(MediaQuery.of(context).size.height * 0.15),
                  LottieBuilder.asset(
                    'assets/images/splash.json',
                    height: 250,
                  ),
                  subText(
                    'Welcome to URL Scanner',
                    fontWeight: FontWeight.w700,
                    size: 23,
                    color: primaryColor,
                  ),
                  addVertical(40),
                  Center(
                    child: (_credentials == null)
                        ? ElevatedButton(
                            onPressed: () async {
                              print('Auth0: ${auth0.toString()}');
                              final credentials = await auth0.webAuthentication().login();
                              setState(() => _credentials = credentials);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Index(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: BorderSide(color: primaryColor, width: 1),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 35,
                                    width: 35,
                                    child: Image.asset('assets/images/google.png'),
                                  ),
                                  addHorizontal(35),
                                  Text(
                                    'Sign In With Google',
                                    style: GoogleFonts.lato(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
