import 'package:e_book/routes/routes.dart';
import 'package:e_book/utils/styles.dart';
import 'package:e_book/view/widgets/user_widgets/custome_book_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/book_model.dart';

class BooksListViewItem extends StatelessWidget {
  BooksListViewItem({required this.book});

final  Book book;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.bookDetailsScreen,arguments: [book]);
      },
      child: SizedBox(
        height: h * 0.3,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: CustomBookImage(imageUrl: book.coverImage),
            ),
            SizedBox(width: w * 0.05),
            Expanded(
              child: Column(
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
            )
          ],
        ),
      ),
    );
  }
}
