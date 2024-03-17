import 'package:e_book/view/widgets/book_details_widgets/Book_preview_button.dart';
import 'package:e_book/view/widgets/book_details_widgets/book_details_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/book_model.dart';

class BookDetailsScreen extends StatelessWidget {
    BookDetailsScreen({super.key} );

    Book book=Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                    BooksDetailsSection(book: book,),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  const BooksPreviewButtton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
