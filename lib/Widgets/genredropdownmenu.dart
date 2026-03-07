// Widget na para sa genre dropdown menu sa library app.
// Tumatanggap ng selected genre at callback function para i-update yung selected genre sa parent widget

import 'package:flutter/material.dart';
import '../Logic/book.dart';

class GenreDropdownMenu extends StatelessWidget {
  final ValueChanged<BookGenre> onGenreSelected;
  final BookGenre selectedGenre;

  const GenreDropdownMenu({
    super.key,
    required this.onGenreSelected,
    required this.selectedGenre,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<BookGenre>(
      menuWidth: 220,
      borderRadius: BorderRadius.circular(10.0),
      hint: Text('Filter by Genre'),
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
