import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../logic/controllers/admin_home_controller.dart';

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
        _buildBookList(), // Function to build the book list
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
                    trailing:adminController.isDecliningUser.value||adminController.isConfirming.value?SizedBox(child: LinearProgressIndicator(color: Colors.blueAccent,),): Row(
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
                                    .usersWithRequist[index].uid);                          },
                        ),
                      ],
                    ),

                  ),
                );
              },
            ),
          ));
  }

  Widget _buildBookList() {
    // This is a dummy list of books, replace it with your actual data
    List<Map<String, dynamic>> books = [
      {
        'title': 'Book 1',
        'category': 'Fiction',
        'author': 'Author 1',
      },
      {
        'title': 'Book 2',
        'category': 'Non-fiction',
        'author': 'Author 2',
      },
    ];

    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: ListTile(
              title: Text(book['title']),
              subtitle: Text(
                  'Category: ${book['category']}, Author: ${book['author']}'),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Navigate to edit book screen for admins
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
