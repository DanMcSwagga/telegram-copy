import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import '../components/drawer.dart';
import '../components/chat_preview.dart';
import '../components/search.dart';
import '../model.dart';
import '../services/dio.dart';
import 'chat_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // with TickerProviderStateMixin<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: ChatListPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/newchat'),
        tooltip: 'New Chat',
        child: Icon(
          Icons.edit,
          size: 20,
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       title: Text('Settings'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.dashboard),
      //       title: Text('Themes'),
      //     ),
      //   ],
      // ),
    );
  }
}
