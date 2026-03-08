// Screen Widget na para sa "To Read" tab ng library app.
// Dito makikita yung listahan ng mga libro na naka mark as "to read"

import 'package:flutter/material.dart';
import 'package:library_app/Logic/book_provider.dart';
import 'package:library_app/Widgets/booklist.dart';
import 'package:library_app/Widgets/genredropdownmenu.dart';
import 'package:provider/provider.dart';
import '../Widgets/searchbar.dart';
import '../Logic/book.dart';

class ToReadScreen extends StatefulWidget {
  const ToReadScreen({super.key});

  @override
  State<ToReadScreen> createState() => _ToReadScreenState(); // Nag-create ng state para sa ToReadScreen, para ma-handle yung search query, selected genre, at filtered books list.
}

class _ToReadScreenState extends State<ToReadScreen> {
  String searchQuery = '';
  BookGenre? selectedGenre;
  List<Book> filteredBooks = [];

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(
      context,
    ); // Kinuha yung BookProvider instance gamit ang Provider.of para makuha yung listahan ng mga libro at magamit yung filterBooks method.

    filteredBooks = bookProvider.filterBooks(
      searchQuery: searchQuery,
      genre: selectedGenre,
      status: BookStatus.toRead,
    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Searchbar(
                    placeholder: 'Search books to be read',
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
                      if (value == BookGenre.none) {
                        selectedGenre = null;
                      } else {
                        selectedGenre = value;
                      }
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
