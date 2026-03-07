// Screen Widget na para sa "Reading" tab ng library app.
// Dito makikita yung listahan ng mga libro na naka mark as "reading"

import 'package:flutter/material.dart';
import 'package:library_app/Logic/book_provider.dart';
import 'package:library_app/Widgets/booklist.dart';
import 'package:library_app/Widgets/genredropdownmenu.dart';
import 'package:provider/provider.dart';
import '../Widgets/searchbar.dart';
import '../Logic/book.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState(); // Nag-create ng state para sa ReadingScreen, para ma-handle yung search query, selected genre, at filtered books list.
}

class _ReadingScreenState extends State<ReadingScreen> {
  String searchQuery = '';
  BookGenre selectedGenre = BookGenre.none;
  List<Book> filteredBooks = [];

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(
      context,
    ); // Kinuha yung BookProvider instance gamit ang Provider.of para makuha yung listahan ng mga libro at magamit yung filterBooks method.

    filteredBooks = bookProvider.filterBooks(
      // Nagfi-filter ng mga libro base sa search query, selected genre, at status na "reading".
      searchQuery: searchQuery,
      genre: selectedGenre,
      status: BookStatus.reading,
    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Searchbar(
                    placeholder: 'Search books currently being read',
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                GenreDropdownMenu(
                  selectedGenre: selectedGenre,
                  onGenreSelected: (value) {
                    setState(() {
                      selectedGenre = value;
                    });
                  },
                ),
              ],
            ),
            Expanded(child: Booklist(books: filteredBooks)),
          ],
        ),
      ),
    );
  }
}
