import 'package:get/get.dart';

import '../../models/user_model.dart';
import '../../services/remote_services/firestore_methods.dart';

class AdminHomeController extends GetxController {
  RxList usersWithRequist = [].obs;

  @override
  void onInit() async {
    getUsersRequistList();
    // TODO: implement onInit
    super.onInit();
  }

  getUsersRequistList() async {
    await FireStoreMethods()
        .users
        .where('isActivateRequist', isEqualTo: true)
        .snapshots()
        .listen((event) {
      usersWithRequist.clear();
      for (int i = 0; i < event.docs.length; i++) {
        usersWithRequist.add(UserModel.fromMap(event.docs[i]));

      }
      update();
    });
    //   update();
  }
}
