import 'package:flutter/material.dart';
import 'book.dart';

class GenreDropdownMenu extends StatelessWidget {
  final ValueChanged<BookGenre> onGenreSelected;
  final BookGenre? selectedGenre = BookGenre.none;

  const GenreDropdownMenu({super.key, required this.onGenreSelected});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<BookGenre>(
      hint: const Text('Select Genre'),
      value: selectedGenre,
      icon: const Icon(Icons.filter_list),
      items: BookGenre.values.map((genre) {
        return DropdownMenuItem<BookGenre>(
          value: genre,
          child: Text(genre.displayName),
        );
      }).toList(),
      onChanged: (selectedGenre) {
        if (selectedGenre != null) {
          onGenreSelected(selectedGenre);
        }
      },
    );
  }
}
