import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_it_up/Database/database_helper.dart';
import 'package:track_it_up/Database/user_operations.dart';
import 'package:track_it_up/Utils/appcolors.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:track_it_up/Utils/common_functions.dart';
import 'package:track_it_up/Utils/local_shared_preferences.dart';
import 'package:track_it_up/Widgets/input_fields.dart';

import 'main_home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController ctlName = TextEditingController();
  TextEditingController ctlHeight = TextEditingController();
  TextEditingController ctlWeight = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    nb.setStatusBarColor(bgColor);
    super.initState();
  }

  void loginUser() {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 3), () async {
      var present = await DatabaseHelper.instance.checkIfPresent(
          'name', ctlName.text.trim(), DatabaseHelper.userDBTableName);

      if (present) {
        CommonFunctions.showErrorSnackbar("Username is already taken.");
        setState(() {
          isLoading = false;
        });
      } else {
        LocalPreferences().setLoginBool(true);
        LocalPreferences().setUserName(ctlName.text.trim());
        // LocalPreferences().setUserHeight(ctlHeight.text.trim());
        // LocalPreferences().setUserWeight(ctlWeight.text.trim());

        double weight = double.parse(ctlWeight.text.trim());

        var requiredCal = "0", requiredProtein = "0", requiredCarbs = "0";

        requiredProtein = (1.5 * weight).toStringAsFixed(2);

        requiredCarbs = "280";

        if (weight <= 60) {
          requiredCal = "2500";
        } else if (weight > 60 && weight <= 70) {
          requiredCal = "2700";
        } else {
          requiredCal = "2900";
        }

        UserOperations()
            .insertUser(
                name: ctlName.text.trim(),
                height: ctlHeight.text.trim(),
                weight: ctlWeight.text.trim(),
                requiredCal: requiredCal,
                requiredProtein: requiredProtein,
                requiredCarbs: requiredCarbs)
            .then((value) {
          setState(() {
            isLoading = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MainHomeScreen(
                        initPageNumber: 0,
                      )));
        });
      }
    });
  }

  @override
  void dispose() {
    ctlName.dispose();
    ctlHeight.dispose();
    ctlWeight.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(children: [
                FadeInUp(
                  child: Text(
                    "Welcome to Track it Up",
                    style: GoogleFonts.nunito(color: textColor, fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: SvgPicture.asset(
                      fit: BoxFit.cover,
                      width: size.width,
                      "assets/svg_images/login_image.svg"),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      FadeInUp(
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.nunito(
                              color: textColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FadeInUp(
                        child: LoginTextField(
                          pref: const Icon(
                            CupertinoIcons.person,
                            color: textColor,
                          ),
                          controllerValue: ctlName,
                          hintText: 'Enter your name',
                          inputType: TextInputType.name,
                          validate: (val) {
                            if (val!.isEmpty) {
                              return "Cant be Empty.";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FadeInUp(
                        child: Row(
                          children: [
                            Expanded(
                              child: LoginTextField(
                                pref: const Icon(
                                  CupertinoIcons.pin_fill,
                                  color: textColor,
                                ),
                                suf: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Cm",
                                      style: GoogleFonts.nunito(
                                          color: textColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                controllerValue: ctlHeight,
                                hintText: 'Height',
                                inputType: TextInputType.number,
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Cant be Empty.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: LoginTextField(
                                pref: const Icon(
                                  CupertinoIcons.pin_fill,
                                  color: textColor,
                                ),
                                suf: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Kg",
                                      style: GoogleFonts.nunito(
                                          color: textColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                controllerValue: ctlWeight,
                                hintText: 'Weight',
                                inputType: TextInputType.number,
                                validate: (val) {
                                  if (val!.isEmpty) {
                                    return "Cant be Empty.";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 10),
                                backgroundColor: accentColor),
                            onPressed: isLoading
                                ? null
                                : () {
                                    final isValid =
                                        _formKey.currentState!.validate();

                                    if (!isValid) {
                                      return;
                                    }
                                    _formKey.currentState!.save();
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    loginUser();
                                  },
                            child: isLoading
                                ? const SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator(
                                      color: whiteColor,
                                    ),
                                  )
                                : Text(
                                    "Sign In",
                                    style: GoogleFonts.nunito(
                                        color: textColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
