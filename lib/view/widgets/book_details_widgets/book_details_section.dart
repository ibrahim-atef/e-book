import 'package:e_book/utils/styles.dart';
import 'package:e_book/view/widgets/user_widgets/custome_book_image.dart';
import 'package:flutter/material.dart';

import '../../../models/book_model.dart';

class BooksDetailsSection extends StatelessWidget {
  BooksDetailsSection({required this.book});

  Book book;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .2),
          child: SizedBox(
            height: width * 0.3,
            child: CustomBookImage(
              imageUrl:
                  book.coverImage,
            ),
          ),
        ),
        const SizedBox(height: 43),
         Text(
        book.title  ,
          textAlign: TextAlign.center,
          style: Styles.textStyle30,
        ),
        const SizedBox(height: 6),
        Opacity(
          opacity: 0.7,
          child: Text(
            book.author,
            style: Styles.textStyle18.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Opacity(
          opacity: 0.7,
          child: Text(
            book.category,
            style: Styles.textStyle16.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
