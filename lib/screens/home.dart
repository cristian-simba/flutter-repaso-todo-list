import 'package:flutter/material.dart';
import 'package:todo_list/screens/components/complete_list.dart';
import 'package:todo_list/screens/components/incomplete_list.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;

  List<Widget> _pages = <Widget>[
    IncompleteList(),
    CompleteList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Tareas"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Tareas Completas"),
        ],
      ),
    );
  }
}