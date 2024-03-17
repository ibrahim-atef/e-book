import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../logic/controllers/auth_controller.dart';
import '../../../utils/my_strings.dart';
import '../../../utils/themes.dart';
import 'auth_text_from_field.dart';

class SignUpCard extends StatefulWidget {
  final double cardWidth;

  SignUpCard({required this.cardWidth});

  @override
  State<SignUpCard> createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
  TextEditingController textEditingController1 = TextEditingController();

  final authController = Get.find<AuthController>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(30.0), // Adjust the radius as needed
      ),
      elevation: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // signIn info filling and auth methods
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Color(0xff71C9CE),
                    Color(0xFFA6E3E9),
                  ],
                ),
                color: Color(0xff71C9CE),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(150),
                  topRight: Radius.circular(150),
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )),
            width: widget.cardWidth * .5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Hello, Friends!",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Keep Reading...",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Enter with your personal details to use all\n of site features",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  width: widget.cardWidth * .25,
                  height: 40,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: GetBuilder<AuthController>(
                      init: AuthController(),
                      builder: (_) {
                        return ElevatedButton(
                          onPressed: () {
                            authController
                                .flipCard(); // Add your sign-up functionality here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: Colors.white), // White border
                            ),
                            elevation:
                                0.0, // Set elevation to 0.0 to remove shadow
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
          GetBuilder<AuthController>(
            builder: (_) {
              return Container(
                width: widget.cardWidth * .445,
                child: Form(
                  key: signUpFormKey,
                  child: Column(
                    //add sign in  formfields and buttons and auth methods
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //add sign in  formfields and buttons and auth methods
                    children: [
                      SizedBox(
                        height: 55,
                      ),
                      const Text(
                        "Create Account",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AuthTextFromField(
                          controller: nameController,
                          obscureText: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your name';
                            } else if (!RegExp(validationName)
                                    .hasMatch(value) &&
                                !RegExp(validationNameWithSpaces)
                                    .hasMatch(value)) {
                              return 'Invalid name';
                            } else {
                              return null;
                            }
                          },
                          hintText: "Name",
                          textInputType: TextInputType.name,
                          suffixIcon: SizedBox()),
                      const SizedBox(
                        height: 5,
                      ),
                      AuthTextFromField(
                          controller: emailController,
                          obscureText: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter an email';
                            } else if (!RegExp(validationEmail)
                                .hasMatch(value)) {
                              return 'Invalid email format';
                            } else {
                              return null;
                            }
                          },
                          hintText: "Email",
                          textInputType: TextInputType.emailAddress,
                          suffixIcon: SizedBox()),
                      const SizedBox(
                        height: 5,
                      ),
                      AuthTextFromField(
                        controller: passwordController,
                        obscureText:
                            authController.signUpPasswordSecure ? true : false,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please enter a password";
                          } else if (value.length < 8) {
                            return "Password is too short (minimum 8 characters)";
                          } else if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return "Password must contain at least one uppercase letter,\n one lowercase letter, one digit,\n and one special character.";
                          } else {
                            return null;
                          }
                        },
                        hintText: "Password",
                        textInputType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            authController.signUpVisibility();
                          },
                          icon: authController.signUpPasswordSecure
                              ? Icon(Icons.visibility_off_outlined, size: 19)
                              : Icon(Icons.visibility_outlined, size: 19),
                          color: DISABLED,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: widget.cardWidth * .25,
                        height: 40,
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            String name = nameController.text;
                            String email = emailController.text.trim();
                            String password = passwordController.text;
                            if (signUpFormKey.currentState!.validate()) {
                              authController.signUpUsingFirebase(
                                email: email,
                                password: password,
                                name: name,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF71C9CE),
                            // Adjust the opacity value
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child:authController.isSignUpLoading.value
                              ? Padding(
                            padding: EdgeInsets.all(5),
                            child: LinearProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                              : Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
