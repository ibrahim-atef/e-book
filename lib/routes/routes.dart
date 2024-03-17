import 'package:e_book/logic/bindings/admin_home_binding.dart';
  import 'package:e_book/view/screens/user/book_details_screen.dart';
import 'package:e_book/view/screens/user/user_home_screen.dart';
import 'package:e_book/view/screens/utiles_screen/unauthorized_screen.dart';
import '../logic/bindings/auth_binding.dart';
import '../services/middlewares_services/auth_middleware.dart';
import '../view/screens/auth_screen/login_screen.dart';
import 'package:get/get.dart';

import '../view/screens/utiles_screen/not_activated_screen.dart';

class Routes {
  static const loginScreen = "/loginScreen";
   static const adminHomeScreen = "/adminHomeScreen";
  static const unauthorized = "/unauthorized";
  static const notActivatedScreen = "/notActivatedScreen";
  static const bookDetailsScreen = "/bookDetailsScreen";
  static const userHomeScreen = "/userHomeScreen";

  static final routes = [
    GetPage(
        name: loginScreen, page: () => LoginScreen(), binding: AuthBinding()),

    GetPage(name: adminHomeScreen, page: () => UserHomeScreen(), middlewares: [
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
    GetPage(
      name: bookDetailsScreen,
      page: () => BookDetailsScreen(),
    ),
     GetPage(
      name: userHomeScreen,
      page: () => UserHomeScreen(),middlewares: [AuthMiddleware()],
    ),
  ];
}
