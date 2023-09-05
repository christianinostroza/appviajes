import 'package:flutter/material.dart';
import 'screens/lugares_screen.dart';
import 'screens/me_interesa_screen.dart';

void main() {
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  List<int> meInteresaItems = []; 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text(_currentIndex == 0 ? 'Lugares' : 'Me Interesa'),
        // ),
        body: _currentIndex == 0
            ? LugaresScreen(meInteresaItems) 
            : MeInteresaScreen(meInteresaItems), 
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.place),
              label: 'Lugares',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_run),
              label: 'Me Interesa',
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
