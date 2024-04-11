import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';

class TypeFormFieldWidget extends StatelessWidget {
  final List passList;
  final Function(dynamic) passedOnSuggestionSelected;
  final String noItemsFoundBuilderString, hintTextString;
  final String validatorString;
  final String? errortext;
  final bool? rOnly;
  final TextEditingController passedController;
  const TypeFormFieldWidget(
      {super.key,
      this.rOnly = true,
      required this.passList,
      required this.passedOnSuggestionSelected,
      required this.noItemsFoundBuilderString,
      required this.hintTextString,
      required this.validatorString,
      required this.passedController,
      this.errortext});

  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField(
      suggestionsCallback: (pattern) => passList.where(
        (item) => item.toUpperCase().contains(pattern.toUpperCase()),
      ),
      itemBuilder: (_, item) => ListTile(
          title: Text(
        item.toString(),
        style: GoogleFonts.nunito(
          fontSize: 12,
        ),
      )),
      onSuggestionSelected: passedOnSuggestionSelected,
      getImmediateSuggestions: true,
      hideSuggestionsOnKeyboardHide: true,
      hideOnEmpty: false,
      noItemsFoundBuilder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          noItemsFoundBuilderString,
          style: GoogleFonts.nunito(
            fontSize: 12,
          ),
        ),
      ),
      textFieldConfiguration: TextFieldConfiguration(
        enabled: rOnly!,
        style: GoogleFonts.nunito(
          fontSize: 12,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 0),

          // labelText: labelTextString,
          hintText: hintTextString,
          hintStyle: GoogleFonts.nunito(
            fontSize: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 1)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red)),
          labelStyle: GoogleFonts.nunito(
            fontSize: 12,
          ),
        ),
        controller: passedController,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return validatorString;
        } else {
          return null;
        }
      },
    );
  }
}
