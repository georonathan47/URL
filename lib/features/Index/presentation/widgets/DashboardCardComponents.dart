import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/widgetFuntions.dart';

class DashboardCardComponent extends StatelessWidget {
  final Widget? icon;
  final String? label;
  final String? value;

  const DashboardCardComponent({Key? key, this.icon, this.label, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.2, 0.2),
            blurRadius: 0.2,
            spreadRadius: 0.1,
            color: Colors.white70,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: icon!),
          addVertical(20),
          Text(
            label!,
            style: GoogleFonts.raleway(
              color: textColor,
              fontSize: 14,
            ),
          ),
          addVertical(20),
          Text(
            value!,
            style: GoogleFonts.raleway(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
