import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../Index/presentation/pages/Dashboard.dart';
import '../../../Index/presentation/pages/QuickScan.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

var _currentIndex = 0;

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: backgroundColor,
      body: navigator(_currentIndex),
      bottomNavigationBar: widgetSelector(),
    );
  }

  SalomonBottomBar widgetSelector() {
    return SalomonBottomBar(
      currentIndex: _currentIndex,
      onTap: (i) => setState(() => _currentIndex = i),
      items: [
        /// Home
        SalomonBottomBarItem(
          icon: const Icon(Icons.dashboard_outlined),
          activeIcon: const Icon(Icons.dashboard),
          title: Text(
            'Dashboard',
            style: GoogleFonts.lato(),
          ),
          selectedColor: Colors.blueAccent,
        ),

        /// Likes
        SalomonBottomBarItem(
          icon: const Icon(Icons.filter_outlined),
          activeIcon: const Icon(Icons.filter),
          title: Text(
            'Quick Scan',
            style: GoogleFonts.lato(),
          ),
          selectedColor: Colors.orange,
        ),

        /// Profile
        // SalomonBottomBarItem(
        //   icon: const Icon(Icons.more_horiz_outlined),
        //   activeIcon: const Icon(Icons.more_horiz),
        //   title: Text(
        //     'More',
        //     style: GoogleFonts.lato(),
        //   ),
        //   selectedColor: Colors.teal,
        // ),
      ],
    );
  }

  Widget? navigator(int index) {
    if (index == 0) {
      return const Dashboard();
    } else if (index == 1) {
      return const QuickScan();
    } else {
      // return const MoreScreen();
    }
    return null;
  }
}
