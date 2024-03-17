import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../logic/controllers/auth_controller.dart';
import '../../../utils/responsive.dart';
import '../../widgets/auth_widgets/login_card.dart';
import '../../widgets/auth_widgets/signup_card.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Color(0xFFEfffff),
              Color(0xFFA6E3E9),
            ],
          ),
        ),
        child: Center(
          child: Responsive(
              mobile: Text("under construction"),
              desktop: GetBuilder<AuthController>(
                builder: (_) {
                  return FlipCard(fill: Fill.fillFront, // Fill the back side of the card to make in the same size as the front.
                    direction: FlipDirection.VERTICAL, // default
                    side: CardSide.FRONT,
                    controller: controller.flipCardController,
                    flipOnTouch: false,
                    front: SizedBox(
                        width: w * .7,
                        height: h * .7,
                        child: LoginCard(
                          cardWidth: w * .7,
                        )),
                    back: SizedBox(
                        width: w * .7,
                        height: h * .7,
                        child: SignUpCard(cardWidth: w * .7)),
                  );
                },
              )),
        ),
      ),
    );
  }
}
