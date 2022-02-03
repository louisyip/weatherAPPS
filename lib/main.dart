import 'package:flutter/material.dart';
import 'mainPage.dart';
import 'savePage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
    
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
List<Widget> _children = [
  MainPage(),
  SavePage(),
  MainPage()
];

int _selectedIndex = 0; 

  
void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _children[_selectedIndex],
       bottomNavigationBar: BottomNavigationBar(
         currentIndex: _selectedIndex, //New
  onTap: _onItemTapped,  
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.add),
        title: Text('Main'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.save),
        title: Text('Saved'),
      )
    ],
  ),
    );
  }
}
