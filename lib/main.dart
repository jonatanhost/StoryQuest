import 'package:flutter/material.dart';
import 'package:storyquest/pages/profile.dart';

import 'pages/library.dart';
import 'pages/home.dart';
import 'powersync.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'StoryQuest'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  final pages = [SplashScreen(), Library(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'StoryQuest',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: pages[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(indicatorColor: Colors.purple.shade200),
        child: NavigationBar(
          height: 60,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.library_books), label: 'Library'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile')
          ],
        ),
      ),
    );
  }
}
