/*
  Eto yung parang nagmamanage nung libro sa library app. Para siyang mini database na laman yung mga libro.
  Yung mga functions dito pang add, update tas filter ng mga libro. 
*/

import 'package:flutter/material.dart';
import 'book.dart';

class BookProvider with ChangeNotifier {
  List<Book> _books = []; // Listahan ng mga libro sa library app

  List<Book> get books =>
      _books; // Getter para makuha yung listahan ng mga libro

  void addBook(Book book) {
    // Function para magdagdag ng libro sa listahan
    _books.add(book);
    notifyListeners();
  }

  void updateProgress(Book book, int newPage, double newProgress) {
    // Function para magupdate ng progress ng libro
    final index = _books.indexOf(book);
    if (index != -1) {
      _books[index].progress = newProgress;
      _books[index].currentPage = newPage;

      if (newProgress >= 100) {
        _books[index].status = BookStatus.read;
      } else if (_books[index].status == BookStatus.toRead) {
        _books[index].status = BookStatus.reading;
      }
      notifyListeners();
    }
  }

  List<Book> filterBooks({
    // Function para magfilter ng mga libro base sa status, search query, at genre
    BookStatus? status,
    String? searchQuery,
    BookGenre? genre,
  }) {
    return _books.where((book) {
      final matchesStatus = status == null || book.status.index == status.index;
      final matchesSearch =
          searchQuery == null ||
          searchQuery == '' ||
          book.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesGenre =
          genre == null || genre == BookGenre.none || book.bookGenre == genre;
      return matchesStatus && matchesSearch && matchesGenre;
    }).toList();
  }
}
