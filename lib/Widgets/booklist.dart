// Widget na para mag-display ng listahan ng mga libro sa iba't ibang screens (To Read, Reading, Read) ng library app.
// Tumatanggap ng listahan ng mga libro bilang input at nagdi-display ng mga ito

import '../Logic/book.dart';
import 'package:flutter/material.dart';
import 'book_card.dart';

class Booklist extends StatelessWidget {
  final List<Book> books;

  const Booklist({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      // Case if walang libro sa listahan, magdi-display ng message na "No books found."
      return const Center(
        child: Text(
          'No books found.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    } else {
      // Case if may libro sa listahan, magdi-display ng ListView.builder para ipakita yung mga libro gamit yung BookCard widget.
      return ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return BookCard(book: books[index]);
        },
      );
    }
  }
}
