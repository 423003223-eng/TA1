import 'package:flutter/material.dart';
import 'book.dart';
import 'booklist.dart';
import 'searchbar.dart';
import 'genredropdownmenu.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final Book bookSample1 = Book(
    title: 'The Great Gatsby',
    totalPages: 180,
    bookGenre: BookGenre.fiction,
  );

  final Book bookSample2 = Book(
    title: 'A Brief History of Time',
    totalPages: 256,
    bookGenre: BookGenre.nonFiction,
  );

  final Book bookSample3 = Book(
    title: 'The Hobbit',
    totalPages: 310,
    bookGenre: BookGenre.fantasy,
  );

  @override
  Widget build(BuildContext context) {
    final List<Book> bookList = [bookSample1, bookSample2, bookSample3];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('My Book Library')),
        body: Center(
          child: Column(
            children: [
              GenreDropdownMenu(onGenreSelected: (genre) {}),
              Searchbar(
                placeholder: 'Search books currently being read',
                onChanged: (value) {
                  // Implement search functionality here
                },
              ),
              Expanded(child: Booklist(books: bookList)),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.book),
              label: 'Reading',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.hourglass_bottom),
              label: 'To Read',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.check),
              label: 'Read',
            ),
          ],
        ),
      ),
    );
  }
}
