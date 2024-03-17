import 'package:get/get.dart';
import '../../models/book_model.dart';
import '../../services/remote_services/firestore_methods.dart';

class UserHomeController extends GetxController {
  @override
  void onInit() async {
    getBooksList();
    super.onInit();
  }

  RxList<Book> booksList = <Book>[].obs;

  getBooksList() async {
    FireStoreMethods().books.snapshots().listen((event) {
      booksList.clear();
      for (int i = 0; i < event.docs.length; i++) {
        booksList.add(Book.fromJson(event.docs[i]));
      }
      update();
    });
  }
}
