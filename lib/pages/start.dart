import 'package:bdatos/pages/cards.dart';
import 'package:bdatos/pages/form.dart';
import 'package:flutter/material.dart';
import 'package:bdatos/pages/photo.dart';

class Start extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    return _MyStart();
  }
}

class _MyStart extends State<Start> {
  int _sletedIndex=0;
  final List <Widget> _paginas=[
    Photo(),
    Cards(),
    Forms(),
    //MapPage(),
  ];
  void _onItemTapped(int index){
    setState(() {
      _sletedIndex=index;
    });
  }
  @override
  Widget build(BuildContext context)
  {
    final colorScheme=Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: _paginas[_sletedIndex],

      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromARGB(100, 103, 58, 183),
          currentIndex: _sletedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.white,
          unselectedItemColor: colorScheme.onSurface.withOpacity(0.8),
          items: const<BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Inicio'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.web),
                label: 'Cards'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_align_justify),
                label: 'Form'
            ),
          ]
      ),
    );
  }
}