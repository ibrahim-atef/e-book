import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controllers/auth_controller.dart';
import '../../../utils/my_strings.dart';
import '../../../utils/themes.dart';
import 'auth_text_from_field.dart';

class LoginCard extends StatefulWidget {
  final double cardWidth;

  LoginCard({required this.cardWidth});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final authController = Get.find<AuthController>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final controller = Get.find<AuthController>();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (_) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: widget.cardWidth * .445,
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 55),
                      const Text(
                        "Sign In",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 35),
                      AuthTextFromField(
                        controller: emailController,
                        obscureText: false,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an email';
                          } else if (!RegExp(validationEmail).hasMatch(value)) {
                            return 'Invalid email format';
                          } else {
                            return null;
                          }
                        },
                        hintText: "Email",
                        textInputType: TextInputType.emailAddress,
                        suffixIcon: SizedBox(),
                      ),
                      const SizedBox(height: 12),
                      AuthTextFromField(
                        controller: passwordController,
                        obscureText:
                            authController.loginPasswordSecure ? true : false,
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
                            authController.loginVisibility();
                          },
                          icon: authController.loginPasswordSecure
                              ? Icon(Icons.visibility_off_outlined, size: 19)
                              : Icon(Icons.visibility_outlined, size: 19),
                          color: DISABLED,
                        ),
                      ),
                      SizedBox(height: 5),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Forgot Your Password?",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Container(
                        width: widget.cardWidth * .25,
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            String email = emailController.text.trim();
                            String password = passwordController.text;
                            if (formKey.currentState!.validate()) {
                              authController.loginUsingFirebase(
                                email: email,
                                password: password,
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF71C9CE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: authController.isLoginLoading.value
                              ? Padding(
                                  padding: EdgeInsets.all(5),
                                  child: LinearProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(150),
                    bottomLeft: Radius.circular(150),
                  ),
                ),
                width: widget.cardWidth * .5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome Back!",
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
                    SizedBox(height: 12),
                    Text(
                      "Register with your personal details to use all\n of site features",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Container(
                      width: widget.cardWidth * .25,
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: GetBuilder<AuthController>(
                        init: AuthController(),
                        builder: (_) {
                          return ElevatedButton(
                            onPressed: () {
                              controller.flipCard();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Colors.white),
                              ),
                              elevation: 0.0,
                            ),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
