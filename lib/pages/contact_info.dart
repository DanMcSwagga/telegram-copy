import 'package:flutter/material.dart';
import "package:provider/provider.dart";

import '../model.dart';

class ContactInfoPage extends StatelessWidget {
  final int id;

  ContactInfoPage({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact $id'),
        actions: <Widget>[
          IconButton(
            onPressed: () => print('Contact call $id pressed.'),
            icon: Icon(Icons.call),
            iconSize: 26,
            tooltip: 'Call',
          ),
          IconButton(
            onPressed: () => print('Contact more $id pressed.'),
            icon: Icon(Icons.more_vert),
            iconSize: 26,
            tooltip: 'More',
          )
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 32.0, .0, .0),
          child: ContactInfo(id: id),
        ),
      ),
    );
  }
}

class ContactInfo extends StatefulWidget {
  ContactInfo({Key key, this.id}) : super(key: key);

  final int id;

  @override
  State<StatefulWidget> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  // Object contact;
  String name = '';
  String height = '';
  String mass = '';
  String birthYear = '';
  String gender = '';

  @override
  void initState() {
    // this._requestContact();
    super.initState();
  }

  // void _requestContact() async {
  //   final response = await dioGetContact(2);
  //   setState(() {
  //     name = response.data['name'];
  //     height = response.data['height'];
  //     mass = response.data['mass'];
  //     birthYear = response.data['birth_year'];
  //     gender = response.data['gender'];
  //   });
  // }

  void _setContactData(context) {
    final ThemedModel model = Provider.of<ThemedModel>(context);
    setState(() {
      // dynamic contact = model.names[widget.id];
      dynamic contact = model.filteredNames[widget.id];
      name = contact['name'];
      height = contact['height'];
      mass = contact['mass'];
      birthYear = contact['birth_year'];
      gender = contact['gender'];
    });
  }

  @override
  Widget build(BuildContext context) {
    _setContactData(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomHeaderField(prop: 'Contact № ${widget.id}', value: name),
        Divider(height: 32.0),
        Text(
          'Info',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 16.0),
        CustomTextField(prop: 'Height', value: height),
        CustomTextField(prop: 'Weight', value: mass),
        CustomTextField(prop: 'Birth year', value: birthYear),
        CustomTextField(prop: 'Gender', value: gender),
        Divider(height: 32.0),
      ],
    );
  }
}

class CustomHeaderField extends StatelessWidget {
  CustomHeaderField({this.prop, this.value});

  final String prop;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(
          '$prop',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField({this.prop, this.value});

  final String prop;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          '$prop',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 24.0),
      ],
    );
  }
}
