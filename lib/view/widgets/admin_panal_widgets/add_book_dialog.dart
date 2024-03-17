import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controllers/admin_home_controller.dart';

class AddBookDialog extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Step 1

  final adminController = Get.find<AdminHomeController>();

  @override
  Widget build(BuildContext context) {
    return GetX(
      builder: (AdminHomeController controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              // Step 2
              key: formKey, // Step 2
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: (value) {
                      // Validation for Title field
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: categoryController,
                    decoration: InputDecoration(labelText: 'Category'),
                    validator: (value) {
                      // Validation for Category field
                      if (value == null || value.isEmpty) {
                        return 'Please enter a category';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: authorController,
                    decoration: InputDecoration(labelText: 'Author'),
                    validator: (value) {
                      // Validation for Author field
                      if (value == null || value.isEmpty) {
                        return 'Please enter an author';
                      }
                      return null;
                    },
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
                    child: adminController.imagePathName.value == ""
                        ? Text('Pick Cover Image')
                        : Text("${adminController.imagePathName.value}"),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      adminController.pickVoice();
                    },
                    child: adminController.audioPathName.value == ""
                        ? Text('Pick Voice')
                        : Text("${adminController.audioPathName.value}"),
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // Step 3
                        adminController.addNewBook(
                          title: titleController.text,
                          category: categoryController.text,
                          author: authorController.text, context: context,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Change button color
                      onPrimary: Colors.white, // Change text color
                    ),
                    child: adminController.isUploadingNewBook.value == true
                        ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              children: [

                                Text("Please wait until upload complete"),   LinearProgressIndicator(
                                  color: Colors.white,
                                ),
                              ],
                            ),
                        )
                        : Text('Add Book'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
