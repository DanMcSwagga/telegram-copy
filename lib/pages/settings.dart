import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:shared_preferences/shared_preferences.dart';

import '../model.dart';
// import '../components/bottom_bar.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: SettingsForm(),
          ),
        ),
      ),
      // bottomNavigationBar: CustomBottomBar(),
    );
  }
}

class SettingsForm extends StatefulWidget {
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  String _haveStartedAppTimes = '';

  @override
  void initState() {
    super.initState();
    _incrementStartup();
  }

  Future<SharedPreferences> _getPrefs() {
    return SharedPreferences.getInstance();
  }

  // Future<int> _getStartupFromSharedPref() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final startupNumber = prefs.getInt('startupNumber');
  //   return startupNumber ?? 0;
  // }
  /// ^ async await | future callback:
  Future<int> _getStartupFromSharedPref() {
    return _getPrefs().then((SharedPreferences prefs) {
      return prefs.getInt('startupNumber') ?? 0;
    });
  }

  // // If ever need to reset the counter
  // Future<void> _resetCounter() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt('startupNumber', 0);
  // }

  // void _incrementStartup() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int lastStartup = await _getStartupFromSharedPref();
  //   int currentStartup = ++lastStartup;
  //   await prefs.setInt('startupNumber', currentStartup);
  //   setState(() => _haveStartedAppTimes = 'Entered app $currentStartup times');
  // }
  /// ^ async await | future callback:
  void _incrementStartup() {
    _getStartupFromSharedPref().then((int lastStartup) {
      return ++lastStartup;
    }).then((int currentStartup) {
      _getPrefs().then((SharedPreferences prefs) {
        prefs.setInt('startupNumber', currentStartup);
      }).then((_) {
        setState(() {
          _haveStartedAppTimes = 'Entered app $currentStartup times';
        });
      });
    });
  }

  //

  @override
  Widget build(BuildContext context) {
    final ThemedModel theme = Provider.of<ThemedModel>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text('Select app theme', style: TextStyle(fontSize: 18)),
        SizedBox(height: 24.0),
        RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          onPressed: () => theme.themeData = ThemeData(
            brightness: Brightness.light,
            // primaryColor: Colors.green,
          ),
          child: Text(
            'Light Theme',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
        SizedBox(height: 16.0),
        RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          onPressed: () => theme.themeData = ThemeData(
            brightness: Brightness.dark,
            // primaryColor: Colors.green,
          ),
          child: Text(
            'Dark Theme',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
        Divider(height: 24.0),
        Text(_haveStartedAppTimes, style: TextStyle(fontSize: 18)),
      ],
    );
  }
}
