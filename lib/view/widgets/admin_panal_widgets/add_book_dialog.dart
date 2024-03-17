import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controllers/admin_home_controller.dart';

class AddBookDialog extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController pdfLinkController = TextEditingController();
  final TextEditingController voiceLinkController = TextEditingController();

  final adminController = Get.find<AdminHomeController>();

  @override
  Widget build(BuildContext context) {
    return GetX(
      builder: (AdminHomeController controller) {
        return SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: authorController,
                decoration: InputDecoration(labelText: 'Author'),
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => adminController.pickPdfFile(),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Change button color
                  onPrimary: Colors.white, // Change text color
                ),
                child: adminController.pdfPathName.value == ""
                    ? Text('Pick Book PDF')
                    : Text("${adminController.pdfPathName.value}"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: adminController.pickCoverImage,
                child:adminController.imagePathName.value == ""
                    ? Text('Pick Cover Image'):Text("${adminController.imagePathName.value}"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed:(){adminController.pickVoice();},
                child:adminController.audioPathName.value == ""
                    ? Text('Pick Voice'):Text("${adminController.audioPathName.value}"),
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Implement logic to upload data to Firestore or handle book creation
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Change button color
                  onPrimary: Colors.white, // Change text color
                ),
                child: Text('Add Book'),
              ),
            ],
          ),
        ));
      },
    );
  }
}
