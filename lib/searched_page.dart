import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tarea3/items/item_book.dart';
import 'package:tarea3/providers/provider.dart';

class SearchPage extends StatelessWidget {
  SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tituloController = TextEditingController();
    dynamic list_books = context.watch<Provide_Book>().list_books;
    dynamic cargando = {
      "items": [
        {
          "volumeInfo": {"title": "Cargando"},
        },
        {
          "volumeInfo": {"title": "Cargando"},
        },
        {
          "volumeInfo": {"title": "Cargando"},
        },
        {
          "volumeInfo": {"title": "Cargando"},
        },
        {
          "volumeInfo": {"title": "Cargando"},
        },
        {
          "volumeInfo": {"title": "Cargando"},
        }
      ]
    };
    bool _enabled = context.watch<Provide_Book>().enabled;
    return Scaffold(
        appBar: AppBar(
            title: const Text('Libreria free to play'),
            backgroundColor: Colors.black),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                  controller: tituloController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Ingresa titulo",
                      label: Text("Ingresa titulo"),
                      labelStyle: TextStyle(color: Colors.grey),
                      focusedBorder: new OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 3),
                      ),
                      suffixIcon: IconButton(
                          onPressed: () async {
                            context.read<Provide_Book>().changeShimmer();
                            await context
                                .read<Provide_Book>()
                                .findBook(tituloController.text);
                            if (list_books == null || list_books.length == 0) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "No se encontraron libros con ese nombre, intente de nuevo",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ));
                            }
                            context.read<Provide_Book>().changeShimmer();
                          },
                          icon: Icon(Icons.search)))),
            ),
            Expanded(
                child: (_enabled)
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.grey,
                        child: Container(
                          child: GridView.count(
                            scrollDirection: Axis.vertical,
                            crossAxisCount: 2,
                            children: List.generate(cargando["items"].length,
                                (index) {
                              return ItemBook(book: cargando["items"][index]);
                            }),
                          ),
                        ),
                      )
                    : ((list_books != null && list_books.length != 0) &&
                            list_books["totalItems"] != 0 &&
                            list_books["items"] != null)
                        ? Container(
                            child: GridView.count(
                              scrollDirection: Axis.vertical,
                              crossAxisCount: 2,
                              children: List.generate(
                                  list_books["items"].length, (index) {
                                return ItemBook(
                                    book: list_books["items"][index]);
                              }),
                            ),
                          )
                        : Center(
                            child: Text(
                                "No se encontro ningun libro con la busqueda"),
                          )),
          ],
        ));
  }
}
