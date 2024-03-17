import 'package:e_book/utils/custom_button.dart';
import 'package:flutter/material.dart';

class BooksPreviewButtton extends StatelessWidget {
  const BooksPreviewButtton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 8.0),
      child: CustomButton(
        width: MediaQuery.of(context).size.width*0.5,
        textColor: Colors.white,
        onPressed: () {},
        title: 'preview',
        fontSize: 20,
        backgroundColor: const Color(0xFFEF8262),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
