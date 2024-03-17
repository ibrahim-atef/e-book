import 'package:e_book/services/middlewares_services/auth_middleware.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>AuthController() ,fenix: false);
    Get.put(()=>AuthMiddleware() );
  }
}
