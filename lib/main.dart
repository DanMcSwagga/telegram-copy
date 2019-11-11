import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import 'pages/home.dart';
import 'pages/settings.dart';
import 'pages/new_chat.dart';

import 'theming/theme_screen.dart';

import 'model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemedModel>(
      builder: (_) => ThemedModel(
        ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
      ),
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemedModel>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Telegram Demo',
      home: HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.red,
      ),
      darkTheme: theme.themeData,
      routes: {
        '/newchat': (context) => NewChatPage(),
        '/settings': (context) => SettingsPage(),
        '/themescreen': (context) => ThemeScreen(),
      },
    );
  }
}
