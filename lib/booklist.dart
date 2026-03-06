import 'book.dart';
import 'package:flutter/material.dart';
import 'book_card.dart';

class Booklist extends StatelessWidget {
  final List<Book> books;

  const Booklist({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return const Center(
        child: Text(
          'No books found.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return BookCard(book: books[index]);
        },
      );
    }
  }
}
