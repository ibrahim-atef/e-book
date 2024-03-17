import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../logic/controllers/auth_controller.dart';
import '../../routes/routes.dart';

class AuthMiddleware extends GetMiddleware {
  final authController = Get.put(AuthController());


  @override
  RouteSettings? redirect(String? route) {
    if (route == Routes.adminHomeScreen && authController.isAdminX == false) {
      // Redirect to unauthorized page for regular users
      return RouteSettings(name: '/unauthorized');
    } else if (route == Routes.homeScreen &&    authController.isAdminX==true) {
      // Redirect to unauthorized page for admins
      return  null;
    }else if (route == Routes.homeScreen && authController.isUserX == false || authController.isAdminX==true) {
      // Redirect to unauthorized page for admins
      return RouteSettings(name: '/unauthorized');
    }
    return null;
  }




}
