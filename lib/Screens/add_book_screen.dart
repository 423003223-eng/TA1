// Screen Widget na para sa pag add ng libro sa library app.
// May form dito para iinput yung title, total pages, at genre ng libro.
// Pag submit, magcecreate siya ng bagong Book object at ipapasa pabalik sa previous screen.

import 'package:flutter/material.dart';
import '../Logic/book.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers para sa mga text fields ng form
  final TextEditingController titleController = TextEditingController();
  final TextEditingController pagesController = TextEditingController();

  BookGenre? selectedGenre;

  // Function para ihandle yung form submission. Ivalidate niya yung form, tapos kung valid,
  // gagawa siya ng bagong Book object at ipapasa pabalik sa previous screen gamit ang Navigator.pop.
  void submitForm() {
    if (_formKey.currentState!.validate()) {
      final newBook = Book(
        title: titleController.text,
        totalPages: int.parse(pagesController.text),
        bookGenre: selectedGenre!,
      );

      Navigator.pop(context, newBook);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Book")),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,

          child: ListView(
            children: [
              /// Title
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Book Title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Enter book title" : null,
              ),

              const SizedBox(height: 16),

              /// Pages
              TextFormField(
                controller: pagesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Total Pages",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter total pages";
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return "Enter a valid number of pages";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              /// Genre Dropdown
              DropdownButtonFormField<BookGenre>(
                hint: const Text("Select a genre"),
                initialValue: selectedGenre,
                decoration: const InputDecoration(
                  labelText: "Genre",
                  border: OutlineInputBorder(),
                ),
                items: BookGenre.values.map((genre) {
                  return DropdownMenuItem(
                    value: genre,
                    child: Text(genre.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGenre = value;
                  });
                },
                validator: (value) {
                  return value == BookGenre.none || value == null
                      ? "Select a genre"
                      : null;
                },
              ),

              const SizedBox(height: 16),

              /// Submit Button
              ElevatedButton(
                onPressed:
                    submitForm, // I-call yung submitForm function pag na-press yung button
                child: const Text("Add Book"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
