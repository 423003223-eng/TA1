// Class file ng book pang store ng mga book details as objects.

enum BookGenre {
  // Enum para sa mga genre ng libro
  none('All'),
  fiction('Fiction'),
  nonFiction('Non-Fiction'),
  mystery('Mystery'),
  scienceFiction('Science Fiction'),
  fantasy('Fantasy'),
  biography('Biography'),
  history('History'),
  romance('Romance'),
  thriller('Thriller'),
  selfHelp('Self-Help');

  const BookGenre(this.displayName);
  final String displayName;
}

enum BookStatus { reading, toRead, read } // Enum para sa status ng libro

class Book {
  final String title;
  int currentPage = 0;
  final int totalPages;
  final BookGenre bookGenre;
  BookStatus status = BookStatus.toRead;
  double progress = 0.0;

  Book({
    // Constructor para sa Book class
    required this.title,
    required this.totalPages,
    required this.bookGenre,
  });
}
