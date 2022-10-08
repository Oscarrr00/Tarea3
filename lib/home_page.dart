import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarea3/providers/provider.dart';
import 'package:tarea3/searched_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tituloController = TextEditingController();
    dynamic list_books;
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
                            await context
                                .read<Provide_Book>()
                                .findBook(tituloController.text);
                            list_books =
                                context.read<Provide_Book>().list_books;
                            if ((list_books != null &&
                                    list_books.length != 0) &&
                                list_books["totalItems"] != null &&
                                list_books["items"] != null) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SearchPage(),
                                ),
                              );
                            } else {
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
                          },
                          icon: Icon(Icons.search)))),
            ),
            Expanded(
                child: Center(child: Text("Ingrese palabra para buscar libro")))
          ],
        ));
  }
}
