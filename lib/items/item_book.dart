import 'package:flutter/material.dart';
import 'package:tarea3/detalles_page.dart';

class ItemBook extends StatelessWidget {
  final dynamic book;
  ItemBook({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    var volumeInfo = book["volumeInfo"];
    var image = volumeInfo["imageLinks"];
    return Container(
      width: 150,
      height: 150,
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetallesPage(book: book),
                  ),
                );
              },
              child: (image != null && image["thumbnail"] != null)
                  ? Image.network(
                      "${image["thumbnail"]}",
                      width: 140,
                      height: 140,
                    )
                  : Image.asset("assets/images/placeholder_book.jpg",
                      width: 140, height: 140),
            ),
            SizedBox(height: 5),
            Text(
              "${volumeInfo!["title"]}",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}
