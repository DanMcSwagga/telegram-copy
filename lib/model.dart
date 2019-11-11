import 'package:flutter/material.dart';

class ThemedModel extends ChangeNotifier {
  ThemedModel(this._themeData);
  // Theme setting
  ThemeData _themeData;
  ThemeData get themeData => _themeData;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // Home contacts info
  List _names = new List();
  List get names => _names;
  set names(List names) {
    _names = names;
    notifyListeners();
  }

  List _filteredNames = new List();
  List get filteredNames => _filteredNames;
  set filteredNames(List filteredNames) {
    _filteredNames = filteredNames;
    notifyListeners();
  }

  String _searchText = '';
  String get searchText => _searchText;
  set searchText(String searchText) {
    _searchText = searchText;
    notifyListeners();
  }
}
