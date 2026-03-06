enum BookGenre {
  none('--Select Genre--'),
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

enum BookStatus { toRead, reading, read }

class Book {
  final String title;
  int currentPage = 0;
  final int totalPages;
  final BookGenre bookGenre;
  BookStatus status = BookStatus.toRead;
  double progress = 0.0;

  Book({
    required this.title,
    required this.totalPages,
    required this.bookGenre,
  });
}
