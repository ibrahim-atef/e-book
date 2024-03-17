import 'dart:ui';

import 'package:e_book/logic/bindings/auth_binding.dart';
import 'package:e_book/routes/routes.dart';
import 'package:e_book/services/local_services/local_storage_helper.dart';
import 'package:e_book/utils/my_strings.dart';
import 'package:e_book/view/screens/utiles_screen/unauthorized_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage.init();
  // await GetStorage.init();

  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyAx9abhUmu7Tqx6NlunwigOtAVe9x8p8jg",
    appId: "1:346045156369:web:bea9df744cf77ff161b5b0",
    messagingSenderId: "346045156369",
    storageBucket: "gs://e-book-df7e8.appspot.com",
    projectId: "e-book-df7e8",
  ));

  /// >>>>>>>>>>>>>>>>>>>>     flutter run -d chrome --web-hostname localhost --web-port 2081
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // final GetStorage savedData = GetStorage();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      scrollBehavior: MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      debugShowCheckedModeBanner: false,
      title: 'E Book',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: Routes.routes,
      unknownRoute: GetPage(
        name: Routes.unauthorized,
        page: () => UnauthorizedScreen(),
      ),
      initialRoute: determineInitialRoute(),
    );
  }

  String determineInitialRoute() {
    final savedRole = LocalStorage.getString("role");
    print(" saved role is $savedRole.");
    if (savedRole == null) {
      print("null user role: Redirecting to login.");
      return Routes.loginScreen;
    } else if (savedRole == adminCollectionKey) {
      return Routes.adminHomeScreen;
    } else if (savedRole == usersCollectionKey) {
      return Routes.userHomeScreen;
    } else {
      print("Unknown user role: $savedRole. Redirecting to login.");
      return Routes.loginScreen;
    }
  }
}
