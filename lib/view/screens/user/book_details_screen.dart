import 'package:e_book/view/widgets/book_details_widgets/Book_preview_button.dart';
import 'package:e_book/view/widgets/book_details_widgets/book_details_section.dart';
import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

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
                  const BooksDetailsSection(),
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
