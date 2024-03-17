import 'package:e_book/logic/controllers/user_home_controller.dart';
import 'package:e_book/view/widgets/user_widgets/books_listview_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BooksListView extends StatelessWidget {
  BooksListView({super.key});

  final userHomeController = Get.find<UserHomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => userHomeController.booksList.length == 0
        ? SizedBox(
            child: Center(child: Text('there is no Books')),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: userHomeController.booksList.length,
            itemBuilder: (context, index) {
              return BooksListViewItem(
                book: userHomeController.booksList[index],
              );
            },
          ));
  }
}
