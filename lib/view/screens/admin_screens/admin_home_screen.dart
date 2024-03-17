import 'package:e_book/utils/responsive.dart';
import 'package:flutter/material.dart';

import '../../widgets/admin_panal_widgets/desktop_admin_panel.dart';
import '../../widgets/admin_panal_widgets/mobile_admin_panal.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add book functionality
        },
        child: Icon(Icons.add),
      ),
    );
  }
}



