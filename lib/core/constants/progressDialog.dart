import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_scan/core/constants/widgetFuntions.dart';

class ProgressDialog extends StatelessWidget {
  final String? displayMessage;

  const ProgressDialog({Key? key, required this.displayMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Card(
        elevation: 0.5,
        child: Padding(
          padding: const EdgeInsets.only(left: 7.5, top: 7.5, bottom: 7.5),
          child: Row(
            children: [
              const CircularProgressIndicator(),
              addHorizontal(15),
              Expanded(
                flex: 2,
                child: Text(
                  displayMessage!,
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: .45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
