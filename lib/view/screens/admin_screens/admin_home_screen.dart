import 'package:e_book/utils/responsive.dart';
import 'package:e_book/view/widgets/admin_panal_widgets/add_book_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controllers/admin_home_controller.dart';
import '../../widgets/admin_panal_widgets/desktop_admin_panel.dart';
import '../../widgets/admin_panal_widgets/mobile_admin_panal.dart';

class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Responsive(
        mobile: MobileAdminPanel(),
        desktop: DesktopAdminPanel(),
      ),
      floatingActionButton: GetBuilder<AdminHomeController>(
        builder: (AdminHomeController adminHomeController) {
          return FloatingActionButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Add Book",
                content: AddBookDialog(),
              ).then((value) {
                adminHomeController.pdfPathName.value = "";
                adminHomeController.imagePathName.value = "";
                adminHomeController.audioPathName.value = "";
              });
            },
            child: Icon(Icons.add),
          );
        },
      ),
    );
  }
}
