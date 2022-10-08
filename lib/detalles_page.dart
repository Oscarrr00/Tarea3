import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tarea3/providers/provider.dart';

class DetallesPage extends StatelessWidget {
  final book;
  const DetallesPage({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var volumeInfo = book["volumeInfo"];
    var image = volumeInfo["imageLinks"];
    TextOverflow overflow = context.watch<Provide_Book>().overflow;
    bool maxLines = context.watch<Provide_Book>().maxLines;
    return Scaffold(
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Detalles del Libro'),
                Row(
                  children: [
                    Icon(Icons.public_rounded),
                    IconButton(
                        onPressed: () {
                          _onShare(volumeInfo);
                        },
                        icon: Icon(Icons.share))
                  ],
                )
              ],
            ),
            backgroundColor: Colors.black),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                (image != null && image["thumbnail"] != null)
                    ? Image.network(
                        "${image["thumbnail"]}",
                      )
                    : Image.asset("assets/images/placeholder_book.jpg",
                        width: 150, height: 150),
                SizedBox(height: 25),
                Text("${volumeInfo["title"]}", style: TextStyle(fontSize: 25)),
                SizedBox(height: 25),
                Align(
                  child: (volumeInfo["publishedDate"] != null)
                      ? Text(
                          "${volumeInfo["publishedDate"]}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )
                      : Text(
                          "-",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                  alignment: Alignment.centerLeft,
                ),
                Align(
                  child: (volumeInfo["pageCount"] != null)
                      ? Text(
                          "Paginas: ${volumeInfo["pageCount"]}",
                          style: TextStyle(fontSize: 15),
                        )
                      : Text(
                          "Paginas: -",
                          style: TextStyle(fontSize: 15),
                        ),
                  alignment: Alignment.centerLeft,
                ),
                GestureDetector(
                  onTap: () {
                    context.read<Provide_Book>().changeOverflow();
                  },
                  child: (volumeInfo["description"] != null)
                      ? Text("${volumeInfo["description"]}",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontStyle: FontStyle.italic),
                          overflow: overflow,
                          maxLines: (maxLines) ? 6 : null)
                      : Text("-", textAlign: TextAlign.justify),
                ),
              ],
            ),
          ),
        ));
  }

  void _onShare(var volumeInfo) async {
    await Share.share(
        "Titulo: ${volumeInfo["title"]} Paginas: ${volumeInfo["pageCount"]}",
        subject: "${volumeInfo["title"]}");
  }
}
