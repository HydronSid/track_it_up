import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_it_up/Utils/appcolors.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController? controllerValue;
  final VoidCallback? onTap;
  final Function(String)? onChange;
  final Widget? pref, suf;
  final bool? rOnly;
  final TextInputType? inputType;
  final TextInputAction? actionNext;
  final bool? obsText;
  final int? mLength;

  final String? Function(String?)? validate;
  final String? hintText;
  const LoginTextField(
      {Key? key,
      this.pref,
      this.suf,
      this.controllerValue,
      this.obsText = false,
      this.validate,
      this.onTap,
      this.rOnly = false,
      this.inputType,
      this.actionNext,
      this.mLength,
      this.hintText,
      this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: false,
      enableInteractiveSelection: false,
      onChanged: onChange,
      style:
          GoogleFonts.nunito(fontSize: 13, letterSpacing: 1, color: textColor),
      cursorColor: whiteColor,
      readOnly: rOnly!,
      textInputAction: actionNext,
      onTap: onTap,
      keyboardType: inputType,
      obscureText: obsText!,
      validator: validate!,
      controller: controllerValue!,
      maxLength: mLength,
      decoration: InputDecoration(
        prefixIcon: pref,
        suffixIcon: suf,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        filled: true,
        fillColor: bgColor,
        counterText: '',
        errorStyle: GoogleFonts.nunito(color: textColor),
        hintText: hintText,
        hintStyle: GoogleFonts.nunito(
          color: textColor,
          fontSize: 12,
          letterSpacing: 1,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 144, 142, 142))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: accentColor, width: 1)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: blackColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red)),
      ),
    );
  }
}
