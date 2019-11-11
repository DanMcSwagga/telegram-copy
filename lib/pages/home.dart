import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import '../components/drawer.dart';
import '../components/chat_preview.dart';
import '../components/search.dart';
import '../model.dart';
import '../services/dio.dart';

class HomePage extends StatefulWidget {
  // HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Temporary lists since _getNames can't receive context for provider
  List _tempNames = List();
  List _tempFilteredNames = List();

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  void _getNames() async {
    final response = await dioGet('https://swapi.co/api/people');
    List tempList = new List();
    for (dynamic item in response.data['results']) {
      tempList.add(item);
    }
    setState(() {
      _tempNames = tempList;
      _tempNames.shuffle();
      _tempFilteredNames = _tempNames;
    });
  }

  Widget _buildList(context) {
    final ThemedModel model = Provider.of<ThemedModel>(context);

    // Assign temporary lists to ones in provider model
    model.names = _tempNames;
    model.filteredNames = _tempFilteredNames;

    if (model.searchText.isNotEmpty) {
      List tempList = new List();
      for (dynamic name in model.filteredNames) {
        if (name['name']
            .toLowerCase()
            .contains(model.searchText.toLowerCase())) {
          tempList.add(name);
        }
      }
      model.filteredNames = tempList;
    }
    return Consumer<ThemedModel>(builder: (context, model, child) {
      return ListView.builder(
        itemCount: model.names == null ? 0 : model.filteredNames.length,
        reverse: false,
        itemBuilder: (context, index) {
          return ChatPreview(
            indexChat: index,
            name: model.filteredNames[index]['name'],
            messagePreview: 'Some message sent by contact.',
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(),
      drawer: Drawer(
        child: CustomDrawer(),
      ),
      body: Container(
        // color: const Color(0xff3a5387),
        child: _buildList(context),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/newchat'),
        tooltip: 'New Chat',
        child: Icon(
          Icons.edit,
          size: 20,
        ),
      ),
    );
  }
}
