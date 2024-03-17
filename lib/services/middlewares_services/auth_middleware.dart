import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controllers/auth_controller.dart';
import '../../routes/routes.dart';

class AuthMiddleware extends GetMiddleware {
  final authController = Get.put(AuthController());

  @override
  RouteSettings? redirect(String? route) {
    if ((authController.isAdminX==true && (route == Routes.adminHomeScreen||route == Routes.userHomeScreen))) {
      // Allow access for admin users to the adminHomeScreen
      return null;
    } else if ( authController.isUserX==false && route == Routes.userHomeScreen) {
      // Redirect to unauthorized page for non-logged-in users trying to access userHomeScreen
      return RouteSettings(name: '/unauthorized');
    }  
    return null; // Allow access to the requested route
  }
}
