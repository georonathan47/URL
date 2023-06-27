// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_scan/features/Generic/presentation/pages/Login.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/progressDialog.dart';
import '../../../../core/constants/widgetFuntions.dart';
import '../../../../core/services/api.dart';
import '../widgets/DashboardCardComponents.dart';

class Dashboard extends StatefulWidget {
  final dynamic total;
  const Dashboard({super.key, this.total});

  @override
  State<Dashboard> createState() => _DashboardState();
}

int allCount = 0;
int phishingCount = 0;
int safeCount = 0;
int susCount = 0;
int malwareCount = 0;
int dnsCount = 0;

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    // initDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Dashboard',
          style: GoogleFonts.raleway(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (_) => const ProgressDialog(displayMessage: "Please wait..."),
              );
              await Future.delayed(const Duration(seconds: 2));
              Api().logout();
              Navigator.pop(context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
            },
            icon: const Icon(Icons.logout, color: error),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8,
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                addVertical(10),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: DashboardCardComponent(
                          icon: const Icon(
                            Icons.home_outlined,
                            color: info,
                          ),
                          label: 'All Scans',
                          value: allCount.toString(),
                        ),
                      ),
                    ),
                    addHorizontal(10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: DashboardCardComponent(
                          icon: const Icon(
                            CupertinoIcons.wrench,
                            color: warning,
                          ),
                          label: 'Phishing Scans',
                          value: phishingCount.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
                addVertical(10),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: DashboardCardComponent(
                          icon: const Icon(
                            Icons.account_balance_outlined,
                            color: Color(0xFFBAABDA),
                          ),
                          label: 'Unsafe Scans',
                          value: safeCount.toString(),
                        ),
                      ),
                    ),
                    addHorizontal(10),
                    Expanded(
                      child: GestureDetector(
                        child: DashboardCardComponent(
                          icon: subTextRaleway('🤔', size: 20),
                          label: 'Suspicious Scans',
                          value: susCount.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
                addVertical(10),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: DashboardCardComponent(
                          icon: const Icon(
                            Icons.nearby_error,
                            color: Color.fromARGB(255, 187, 60, 62),
                          ),
                          label: 'Malware-Infected Scans',
                          value: malwareCount.toString(),
                        ),
                      ),
                    ),
                    addHorizontal(10),
                    Expanded(
                      child: GestureDetector(
                        child: DashboardCardComponent(
                          icon: Icon(Icons.check_box, color: Colors.teal[400]),
                          label: 'Valid DNS Scans',
                          value: dnsCount.toString(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
