import 'package:e_book/logic/bindings/admin_home_binding.dart';
import 'package:e_book/view/screens/admin_screens/admin_home_screen.dart';
import 'package:e_book/view/screens/home_screen.dart';
import 'package:e_book/view/screens/user/user_homepage.dart';
import 'package:e_book/view/screens/utiles_screen/unauthorized_screen.dart';
import '../logic/bindings/auth_binding.dart';
import '../services/middlewares_services/auth_middleware.dart';
import '../view/screens/auth_screen/login_screen.dart';
import 'package:get/get.dart';

import '../view/screens/utiles_screen/not_activated_screen.dart';

class Routes {
  static const loginScreen = "/loginScreen";
  static const homeScreen = "/homeScreen";
  static const adminHomeScreen = "/adminHomeScreen";
  static const unauthorized = "/unauthorized";
  static const notActivatedScreen = "/notActivatedScreen";

  static final routes = [
    GetPage(
        name: loginScreen, page: () => LoginScreen(), binding: AuthBinding()),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),  // navigte to user screen علشان اشوف انا بعمل اي 
      middlewares: [AuthMiddleware()],
    ),
    GetPage(name: adminHomeScreen, page: () => UserHomePage(), middlewares: [
      AuthMiddleware(),
    ], bindings: [
      AdminHomeBinding(),
    ]),
    GetPage(
      name: unauthorized,
      page: () => UnauthorizedScreen(),
    ),
    GetPage(
      name: notActivatedScreen,
      page: () => NotActivatedScreen(),
    ),
  ];
}
