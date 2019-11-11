import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import '../model.dart';

/* Search bar example
 * ORIGINAL
 * https://medium.com/flutterpub/a-simple-search-bar-in-flutter-f99aed68f523
 * or [Seems better]
 * https://medium.com/flutterpub/implementing-search-in-flutter-17dc5aa72018
 * https://www.youtube.com/watch?v=Wm3OiFBZ2xI
 * 
 * extending App Bar:
 * https://www.youtube.com/watch?v=cLbNY2nCuYw
 */

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  SearchAppBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final TextEditingController _filter = new TextEditingController();

  // String _searchText = '';
  Widget _appBarTitle = new Text(
    'Telegram Copy',
    style: TextStyle(fontSize: 20.0),
  );
  Icon _searchIcon = new Icon(Icons.search);
  Icon _menuIcon = new Icon(Icons.menu);

  _SearchAppBarState() {
    _filter.addListener(() {
      final ThemedModel model = Provider.of<ThemedModel>(context);

      if (_filter.text.isEmpty) {
        model.filteredNames = model.names;
        model.searchText = '';
      } else {
        model.searchText = _filter.text;
      }
    });
  }

  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = Icon(Icons.close);
        _menuIcon = Icon(Icons.arrow_back);
        _appBarTitle = TextField(
          // cursorColor: Colors.white,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            // color: Colors.white,
          ),
          controller: _filter,
          decoration: InputDecoration.collapsed(
            hintStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              // color: Colors.white,
            ),
            hintText: 'Search',
          ),
        );
      } else {
        _resetSearch();
      }
    });
  }

  void _resetSearch() {
    final ThemedModel model = Provider.of<ThemedModel>(context);

    model.filteredNames = model.names;

    setState(() {
      _searchIcon = new Icon(Icons.search);
      _menuIcon = new Icon(Icons.menu);
      _appBarTitle = new Text('Telegram Copy');
      _filter.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () => _menuIcon.icon == Icons.arrow_back
              ? _resetSearch()
              : Scaffold.of(context).openDrawer(),
          icon: _menuIcon,
          iconSize: 26,
          // color: Colors.white,
        ),
      ),
      title: _appBarTitle,
      actions: <Widget>[
        IconButton(
          onPressed: () => _searchPressed(),
          icon: _searchIcon,
          iconSize: 26,
          // color: Colors.white,
        )
      ],
    );
  }
}
