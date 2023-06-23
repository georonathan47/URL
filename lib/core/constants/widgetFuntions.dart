import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

SizedBox addVertical(double height) {
  return SizedBox(height: height);
}

SizedBox addHorizontal(double width) {
  return SizedBox(width: width);
}

AppBar globalAppBar(
  BuildContext context, {
  String? title,
  bool? isFromDashboard,
  String? userImage,
  Widget? centerWidget,
  Color? backColor,
}) {
  return AppBar(
    elevation: 0.5,
    backgroundColor: backColor ?? backgroundColor,
    leading: isFromDashboard == true
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipOval(
              child: CircleAvatar(
                child: Image.network(userImage!),
              ),
            ),
          )
        : IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.navigate_before,
              color: Colors.black,
              size: 35,
            ),
          ),
    title: isFromDashboard == false
        ? Text(
            title!,
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 16,
            ),
          )
        : centerWidget,
  );
}

AppBar normalAppBar(
  BuildContext context, {
  String? title,
  bool? isFromDashboard,
  double? elevation,
}) {
  return AppBar(
    elevation: elevation ?? 0.75,
    backgroundColor: Colors.white,
    leading: isFromDashboard == true
        ? null
        : IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.navigate_before,
              color: Colors.black,
              size: 35,
            ),
          ),
    title: Text(
      title!,
      style: GoogleFonts.raleway(
        fontWeight: FontWeight.w700,
        letterSpacing: .35,
        color: textColor,
        fontSize: 20,
      ),
    ),
  );
}

GestureDetector midgetButton(
  BuildContext context, {
  Icon? icon,
  dynamic onPressed,
  String? text,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
      ),
      child: icon!,
    ),
  );
}

SingleChildScrollView screenBody(BuildContext context, {List<Widget>? children}) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    padding: const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 10,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children!,
    ),
  );
}

Text subText(String? text, {double? size, Color? color, FontWeight? fontWeight}) {
  return Text(
    text!,
    style: GoogleFonts.lato(
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ?? Colors.black,
      fontSize: size ?? 14,
    ),
  );
}

Text subTextRaleway(String text, {double? size, Color? color, FontWeight? fontWeight}) {
  return Text(
    text,
    style: GoogleFonts.raleway(
      fontWeight: fontWeight ?? FontWeight.w500,
      color: color ?? Colors.black,
      fontSize: size ?? 14,
    ),
    maxLines: 3,
    softWrap: true,
  );
}

Text emphasisText(String? text, {double? size, Color? color, FontWeight? fontWeight}) {
  return Text(
    text!,
    style: GoogleFonts.lato(
      fontWeight: fontWeight ?? FontWeight.w700,
      color: color ?? Colors.black,
      fontSize: size ?? 24,
    ),
  );
}

Widget buildTextField(
  String labelText,
  String placeholder,
  bool isPasswordTextField,
  bool uneditable,
  TextEditingController controller, {
  bool? isContact,
  bool showPassword = false,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 1.5, left: 5, right: 5, bottom: 7.5),
    child: TextFormField(
      readOnly: uneditable ? true : false,
      obscureText: isPasswordTextField ? true : false,
      controller: controller,
      keyboardType: isContact == true ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: isPasswordTextField
            ? const Icon(
                Icons.lock_outline_rounded,
                color: info,
                size: 20,
              )
            : isContact == true
                ? const Icon(
                    Icons.email_outlined,
                    color: info,
                    size: 20,
                  )
                : const Icon(
                    Icons.alternate_email,
                    color: info,
                    size: 20,
                  ),
        suffixIcon: isPasswordTextField
            ? IconButton(
                onPressed: () {
                  showPassword = !showPassword;
                },
                icon: Icon(
                  Icons.remove_red_eye,
                  color: Colors.red[200],
                ),
              )
            : null, // * This makes the icon appear only for the password field
        contentPadding: const EdgeInsets.only(left: 15),
        labelText: labelText,
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: placeholder,
        hintStyle: GoogleFonts.raleway(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
        labelStyle: GoogleFonts.raleway(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
          letterSpacing: .25,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black54, width: 0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: info, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
  );
}

double getFontSize(BuildContext context, double fontSize) {
  // Define your desired base font size
  double baseFontSize = fontSize;

  // Calculate the scaling factor based on the screen width
  final screenWidth = MediaQuery.of(context).size.width;
  final scalingFactor = screenWidth / 375; // 375 is a reference screen width

  // Calculate the perfect font size by multiplying the base font size with the scaling factor
  final perfectFontSize = baseFontSize * scalingFactor;

  return perfectFontSize;
}

Text addSubTitle(
  BuildContext context,
  String subtitle, {
  FontWeight? fontWeight,
  double? fontSize,
  Color? color,
  double? letterSpacing,
}) {
  return Text(
    subtitle,
    style: GoogleFonts.raleway(
      color: color,
      fontSize: getFontSize(context, fontSize ?? 14),
      fontWeight: fontWeight ?? FontWeight.w500,
      letterSpacing: letterSpacing ?? 0.75,
    ),
  );
}

Widget buildTextField2(
  String labelText,
  String placeholder,
  bool uneditable,
  Widget icon,
  TextEditingController controller, {
  String? errorText,
  bool? isName,
  bool? isEmail,
  bool? isPhone,
  bool? showPassword,
  bool? isAmount,
  InputDecoration? inputDecoration,
  Color? textfieldColor,
  bool? isDarkMode,
  Function(String)? onChanged,
  void Function()? showPasswordContents,
  String Function(String?)? validator,
  int? maxLines,
  Color? textColor,
}) {
  return Card(
    child: TextFormField(
      readOnly: uneditable ? true : false,
      controller: controller,
      obscureText: showPassword == false ? true : false,
      keyboardType: isPhone == true
          ? TextInputType.phone
          : isAmount == true
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
      validator: validator,
      maxLines: maxLines ?? 1,
      decoration: inputDecoration ??
          InputDecoration(
            labelText: labelText,
            hintText: placeholder,
            prefix: icon,
            contentPadding: maxLines == 3 ? const EdgeInsets.all(15) : const EdgeInsets.only(left: 15),
            errorText: errorText,
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
              borderSide: const BorderSide(color: backgroundColor, width: 0.5),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: backgroundColor, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
    ),
  );
}
