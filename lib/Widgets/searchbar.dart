// Widget na para sa search bar sa library app.
// Tumatanggap ng placeholder text at callback function para i-update yung search query sa parent widget

import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  final String placeholder;
  final ValueChanged<String> onChanged;

  const Searchbar({
    super.key,
    required this.placeholder,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: placeholder,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
