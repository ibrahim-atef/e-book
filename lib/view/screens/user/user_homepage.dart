import 'package:e_book/view/widgets/user_widgets/books_list_view.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        centerTitle: true,
        title: const Text('E-Book',
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),), 
      ),
      body: const BooksListView(),
    );
  }
}
