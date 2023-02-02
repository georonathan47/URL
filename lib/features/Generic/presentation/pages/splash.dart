import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'Index.dart';
import 'Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;
  bool proceed = false;

  int customers = 0;

  @override
  void initState() {
    super.initState();

    // initDB();

    controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    animation = CurvedAnimation(parent: controller!, curve: Curves.bounceOut);

    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });
    controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        proceed = true;
        goToLogin();
        // goToHome();
      }
    });
  }

  // void initDB() async {
  //   try {
  //     await db.initialize();
  //     List<CustomerInfoModel>? list = await db.getAllCustomers();
  //     if (list!.isNotEmpty) {
  //       setState(() {
  //         customers = list.length;
  //       });
  //     }
  //   } catch (e) {
  //     print('init db error: $e');
  //   }
  // }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  Future<void> goToLogin() async {
    // if (customers > 0) {
    // goToHome();
    // } else {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }

  Future<void> goToHome() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const Index(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.scale(
        scale: 1.25,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/images/splash.json',
                height: animation!.value * 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
