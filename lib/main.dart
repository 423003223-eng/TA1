import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Logic/book.dart';
import 'Logic/book_provider.dart';
import 'Screens/reading_screen.dart';
import 'Screens/to_read_screen.dart';
import 'Screens/add_book_screen.dart';
import 'Screens/read_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BookProvider()),
      ], // Nag-setup ng MultiProvider para sa buong app, kung saan nagre-register ng BookProvider bilang ChangeNotifierProvider para ma-manage yung state ng mga libro sa app.
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedStatus = BookStatus.reading.index;

  final List<Widget> _screens = [
    // Listahan ng mga screens para sa bawat tab (Reading, To Read, Read) ng library app.
    const ReadingScreen(),
    const ToReadScreen(),
    const ReadScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
      ),

      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('My Book Library'),
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          ),

          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 255, 255, 255),
                  Color.fromARGB(255, 255, 255, 255),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),

            child: Center(
              child: IndexedStack(
                index: selectedStatus,
                children: _screens,
              ), // Ginagamit ang IndexedStack para mag-display ng tamang screen base sa selectedStatus index, para ma-switch yung view kapag nagta-tap sa bottom navigation bar.
            ),
          ),

          floatingActionButton: FloatingActionButton(
            // Floating action button para mag-add ng bagong libro sa library app, kapag na-tap, magna-navigate papunta sa AddBookScreen kung saan pwedeng mag-input ng details ng bagong libro.
            child: const Icon(Icons.add),
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            elevation: 6,
            onPressed: () async {
              final Book? newBook = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddBookScreen(),
                ), // Nagna-navigate papunta sa AddBookScreen gamit ang Navigator.push, at naghihintay ng result na bagong libro na ia-add sa library.
              );
              if (newBook != null) {
                Provider.of<BookProvider>(
                  context,
                  listen: false,
                ).addBook(newBook);
              }
            },
          ),

          bottomNavigationBar: BottomNavigationBar(
            // Bottom navigation bar para mag-switch sa pagitan ng Reading, To Read, at Read screens ng library app.
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: const Color.fromARGB(255, 50, 50, 50),
            showUnselectedLabels: true,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            type: BottomNavigationBarType.fixed,

            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.book),
                label: 'Reading',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.hourglass_bottom),
                label: 'To Read',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.check),
                label: 'Read',
              ),
            ],
            currentIndex: selectedStatus,
            onTap: (index) {
              setState(() {
                selectedStatus = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
