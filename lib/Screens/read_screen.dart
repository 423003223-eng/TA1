// Screen Widget na para sa "Read" tab ng library app.
// Dito makikita yung listahan ng mga libro na naka mark as "read" ng user.

import 'package:flutter/material.dart';
import 'package:library_app/Logic/book_provider.dart';
import 'package:library_app/Widgets/booklist.dart';
import 'package:library_app/Widgets/genredropdownmenu.dart';
import 'package:provider/provider.dart';
import '../Widgets/searchbar.dart';
import '../Logic/book.dart';

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  String searchQuery = '';
  BookGenre? selectedGenre;
  List<Book> filteredBooks = [];

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(
      context,
    ); // Kinuha yung BookProvider instance gamit ang Provider.of para makuha yung listahan ng mga libro at magamit yung filterBooks method.

    filteredBooks = bookProvider.filterBooks(
      // Nagfi-filter ng mga libro base sa search query, selected genre, at status na "read".
      searchQuery: searchQuery,
      genre: selectedGenre,
      status: BookStatus.read,
    );

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Searchbar(
                    placeholder: 'Search read books',
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
