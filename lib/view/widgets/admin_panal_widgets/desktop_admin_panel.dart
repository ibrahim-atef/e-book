import 'package:e_book/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../logic/controllers/admin_home_controller.dart';
import '../../../utils/styles.dart';
import '../user_widgets/custome_book_image.dart';

class DesktopAdminPanel extends StatelessWidget {
  final adminController = Get.find<AdminHomeController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'User Requests',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        _buildBookRequestCard(), // Function to build the book request card
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Manage Books',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        _buildBookList(context),
        // Function to build the book list
      ],
    );
  }

  Widget _buildBookRequestCard() {
    return Obx(() => adminController.usersWithRequist.length == 0
        ? SizedBox(
            child: Center(child: Text('there is no user requist')),
          )
        : SizedBox(
            child: ListView.builder(
              itemCount: adminController.usersWithRequist.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                String formattedDate = DateFormat('dd/MM/yyyy').format(
                    adminController.usersWithRequist[index].registerDate
                        .toDate());
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: ListTile(
                    title: Text(
                        '${adminController.usersWithRequist[index].name} - Requested on $formattedDate'),
                    trailing: adminController.isDecliningUser.value ||
                            adminController.isConfirming.value
                        ? SizedBox(
                            child: LinearProgressIndicator(
                              color: Colors.blueAccent,
                            ),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.check),
                                onPressed: () {
                                  adminController.confirmUserRequest(
                                      userId: adminController
                                          .usersWithRequist[index].uid);
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  adminController.declineUserRequest(
                                      userId: adminController
                                          .usersWithRequist[index].uid);
                                },
                              ),
                            ],
                          ),
                  ),
                );
              },
            ),
          ));
  }

  Widget _buildBookList(context) {
    // This is a dummy list of books, replace it with your actual data

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Obx(() => adminController.booksList.length == 0
        ? SizedBox(
            child: Center(child: Text('there is no Books')),
          )
        : SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: adminController.booksList.length,
              itemBuilder: (context, index) {
                final book = adminController.booksList[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: SizedBox(
                    height: h * 0.3,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: CustomBookImage(imageUrl: book.coverImage),
                        ),
                        SizedBox(width: w * 0.05),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: w * 0.5,
                              child:  Text(
                                book.title,
                                style: Styles.textStyle20,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(height: h * .03),
                              Text(
                              book.author,
                              style: Styles.textStyle14,
                            ),
                            SizedBox(height: h * .03),
                            Text(
                              book.category,
                              style: Styles.textStyle14,
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.delete)),

                      ],
                    ),
                  ),
                );
              },
            ),
          ));
  }
}
