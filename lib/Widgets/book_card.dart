// Reusable Widget na para sa pag-display ng bawat libro sa listahan.
// Nagdi-display ng title, genre, progress, at may button para mag-update ng progress ng libro.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Logic/book.dart';
import '../Logic/book_provider.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  void showUpdateProgress(BuildContext context) {
    // Function na para magpakita ng bottom sheet para i-update yung reading progress ng libro.
    final TextEditingController pageController = TextEditingController();
    final formKey = GlobalKey<FormState>(); // Added form key for validation

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),

          child: Form(
            key: formKey, // Assigned the form key
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Update Reading Progress",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                Text(
                  "${book.title} - ${book.currentPage}/${book.totalPages} pages",
                  style: TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: pageController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter current page";
                    }
                    final page = int.tryParse(value);
                    if (page == null || page < 0 || page > book.totalPages) {
                      return "Enter a valid page number (0-${book.totalPages})";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Current Page",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  // Function na para i-save yung bagong reading progress. Kinukuha niya yung current page
                  //mula sa text field, kino-compute yung new progress percentage, tapos tinatawag yung
                  //updateProgress method ng BookProvider para i-update yung libro.
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Added validation check
                      final newPage = int.parse(pageController.text);
                      final newProgress = (newPage / book.totalPages) * 100;
                      Provider.of<BookProvider>(
                        context,
                        listen: false,
                      ).updateProgress(book, newPage, newProgress);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Changed from 100 to allow flexible width
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.deepPurple, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          spacing: 10.0,
          children: [
            Icon(
              Icons.book,
              size: 50.0,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            Expanded(
              // Added to allow the Column to take available space
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Genre: ${book.bookGenre.displayName}'),
                  Text('Progress: ${book.progress.toStringAsFixed(1)}%'),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: LinearProgressIndicator(
                      value: book.progress / 100,
                      backgroundColor: Colors.grey[300],
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            if (book.status != BookStatus.read)
              ElevatedButton(
                onPressed: () {
                  showUpdateProgress(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                child: const Text('Update Progress'),
              ),
          ],
        ),
      ),
    );
  }
}
