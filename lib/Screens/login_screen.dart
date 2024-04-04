import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:track_it_up/Utils/appcolors.dart';
import 'package:nb_utils/nb_utils.dart' as nb;
import 'package:track_it_up/Utils/local_shared_preferences.dart';
import 'package:track_it_up/Widgets/input_fields.dart';

import 'home_screen.dart';

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

    Future.delayed(const Duration(seconds: 3), () {
      LocalPreferences().setUserName(ctlName.text.trim());
      LocalPreferences().setUserHeight(ctlHeight.text.trim());
      LocalPreferences().setUserWeight(ctlWeight.text.trim());
      LocalPreferences().setLoginBool(true);

      setState(() {
        isLoading = false;
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          backgroundColor: bgColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInUp(
                              child: SvgPicture.asset(
                                  "assets/svg_images/login_image.svg"),
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
                            FadeInUp(
                              child: Text(
                                "Welcome to Track it Up",
                                style: GoogleFonts.nunito(
                                    color: textColor, fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 45,
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
          ),
        ));
  }
}
