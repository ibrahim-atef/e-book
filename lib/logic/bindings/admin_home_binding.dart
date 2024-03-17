import 'package:e_book/logic/controllers/admin_home_controller.dart';
import 'package:get/get.dart';



class AdminHomeBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AdminHomeController());

  }
}
