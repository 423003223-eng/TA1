import 'package:flutter/material.dart';
import 'book.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 90,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 181, 255, 191),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsetsGeometry.all(10.0),
        child: Row(
          spacing: 10.0,
          children: [
            Icon(
              Icons.book,
              size: 50.0,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  book.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Genre: ${book.bookGenre.toString().split('.').last}'),
                Text('Progress: ${book.progress.toStringAsFixed(1)}%'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
