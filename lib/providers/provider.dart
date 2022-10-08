import 'package:flutter/material.dart';
import 'package:tarea3/classes/request.dart';

class Provide_Book with ChangeNotifier {
  RequestHttp httpBooks =
      new RequestHttp(url: "https://www.googleapis.com/books/v1/volumes?q=");
  dynamic list_books = [];
  bool enabled = false;

  TextOverflow overflow = TextOverflow.ellipsis;
  bool maxLines = true;

  Future<void> findBook(String name) async {
    list_books = await httpBooks.getBook(name);
    notifyListeners();
  }

  void changeOverflow() {
    if (overflow == TextOverflow.ellipsis) {
      overflow = TextOverflow.visible;
      maxLines = false;
    } else {
      overflow = TextOverflow.ellipsis;
      maxLines = true;
    }
    notifyListeners();
  }

  void changeShimmer() {
    enabled = !enabled;
    notifyListeners();
  }
}
