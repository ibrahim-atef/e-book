import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Obx(() => adminController.usersWithRequist.length==0?SizedBox(child: Text('there is no user requist') ,): SizedBox(
          child: ListView.builder(
            itemCount: adminController.usersWithRequist.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: ListTile(
                  title: Text('${adminController.usersWithRequist[index]} - Requested on 10/03/2024'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          // Accept the user's registration request
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          // Reject the user's registration request
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
