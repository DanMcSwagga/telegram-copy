import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import '../model.dart';

class NewChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Chat'),
      ),
      body: Container(
        // color: const Color(0xff3a5387),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: NewChatForm(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Sent back to HomePage'),
              );
            },
          );
        },
        tooltip: 'Add Chat',
        child: Icon(
          Icons.arrow_back,
          size: 20,
        ),
      ),
    );
  }
}

class NewChatForm extends StatefulWidget {
  @override
  _NewChatFormState createState() => _NewChatFormState();
}

class _NewChatFormState extends State<NewChatForm> {
  final _contactController = TextEditingController();
  final _messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _contactController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _createChat(_context) {
    final ThemedModel model = Provider.of<ThemedModel>(_context);
    print('Creating chat of contact: $_contactController.text');

    model.names.add({'name': _contactController.text});
  }

  void _showSnackBar(_context) {
    Scaffold.of(_context).showSnackBar(
      SnackBar(
        content: Text('Creating new chat...'),
      ),
    );
  }

  void _exitWithDelay1(_context) {
    Future.delayed(Duration(seconds: 1), () {
      Navigator.pop(_context);
      return showDialog(
        context: _context,
        builder: (_context) {
          return AlertDialog(
            content: Text('New Chat created'),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Center(
            child: Text(
              'Create new chat',
              style: TextStyle(
                // color: const Color(0xfff2f2f2),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          CustomFormField(text: 'Contact', controller: _contactController),
          CustomFormField(text: 'Message', controller: _messageController),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              // color: Colors.blue,
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _createChat(context);
                  _showSnackBar(context);
                  _exitWithDelay1(context);
                }
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  // color: const Color(0xfff2f2f2),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomFormField extends StatelessWidget {
  CustomFormField({this.text, this.controller});

  final String text;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Enter a $text',
        hintStyle: TextStyle(
          // color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        labelText: '$text',
        labelStyle: TextStyle(
          // color: Colors.blue,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      // cursorColor: Colors.white,
      controller: controller,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        // color: Colors.white,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
