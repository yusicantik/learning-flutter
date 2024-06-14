import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: "My World App",
        theme: ThemeData(
            useMaterial3: false,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent)),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  var history = <WordPair>[];
  void toggleHistory() {
    if (history.contains(current)) {
      history.remove(current);
    } else {
      history.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
      case 1:
        page = FavoritePage();
      case 2:
        page = HistoryPage();
      default:
        page = const Placeholder();
    }
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (value) {
            setState(() {
              selectedIndex = value;
            });
          },
          selectedIndex: selectedIndex,
          destinations: const [
            NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Home'),
            NavigationDestination(
                selectedIcon: Icon(Icons.favorite),
                icon: Icon(Icons.favorite_border_outlined),
                label: 'My Favorite'),
            NavigationDestination(
                selectedIcon: Icon(Icons.history),
                icon: Icon(Icons.history_outlined),
                label: 'My History'),
          ],
        ),
        body: Container(
          child: page,
        ));
  }
}

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        "My New Word",
        style: TextStyle(color: Colors.pinkAccent, fontSize: 48.0),
      ),
      BigCard(pair: pair),
      SizedBox(height: 30, width: 50),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
              onPressed: () {
                appState.toggleFavorite();
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text('My Un/-Favorite word ${appState.current}'),
                    ),
                  );
              },
              icon: Icon(icon),
              // icon: const Icon(Icons.favorite_outline),
              label:
                  const Text("My Favorite", style: TextStyle(fontSize: 20.0))),
          const SizedBox(width: 30),
          ElevatedButton.icon(
              onPressed: () {
                appState.getNext();
                print("Button Pressed");
              },
              icon: Icon(Icons.ads_click),
              label:
                  const Text("Click This!", style: TextStyle(fontSize: 20.0))),
        ],
      )
    ]));
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.primary,
      fontSize: 36.0,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
        ),
      ),
    );
  }
}

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Container(
      child: ListView(
        children: [
          Text(
            'My ${appState.favorites.length} Favorite words:',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ...appState.favorites.map(
            (wp) => ListTile(
              title: Text(wp.asCamelCase),
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Container(
      child: ListView(
        children: [
          Text(
            'My ${appState.favorites.length} History Words: ',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ...appState.favorites.map(
            (wp) => ListTile(
              title: Text(wp.asCamelCase),
            ),
          ),
        ],
      ),
    );
  }
}
