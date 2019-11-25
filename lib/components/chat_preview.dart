import 'package:flutter/material.dart';

import '../pages/contact_info.dart';

/* 
 * 1px issue happening because of border:
 * https://github.com/flutter/flutter/issues/25009
 */

class ChatPreview extends StatefulWidget {
  // ChatPreview({Key: key, this.indexChat, this.name, this.messagePreview}) : super(Key: key);
  ChatPreview({this.indexChat, this.name, this.messagePreview})
      : super(key: UniqueKey());

  final int indexChat;
  final String name;
  final String messagePreview;

  _ChatPreviewState createState() => _ChatPreviewState();
}

class _ChatPreviewState extends State<ChatPreview> {
  _ChatPreviewState() {
    //
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // color: const Color(0xff3a5387),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ChatPreviewHeroAvatar(
            index: widget.indexChat,
          ),
          ChatPreviewData(
            index: widget.indexChat,
            name: widget.name,
            message: widget.messagePreview,
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContactInfoPage(id: widget.indexChat),
          ),
        );
      },
    );
  }
}

class ChatPreviewHeroAvatar extends StatelessWidget {
  ChatPreviewHeroAvatar({this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 58,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: ClipOval(
        child: Hero(
          tag: 'imageHero$index',
          child: Image(
            image: ExactAssetImage('images/profile_$index.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class ChatPreviewAvatar extends StatelessWidget {
  ChatPreviewAvatar({this.avatarImageAsset});

  final String avatarImageAsset;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        height: 56,
        width: 56,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(avatarImageAsset),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(const Radius.circular(50.0)),
        ),
      ),
    );
  }
}

class ChatPreviewData extends StatelessWidget {
  ChatPreviewData({this.index, this.name, this.message});

  final int index;
  final String name;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: const Color(0xff727272)),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(4, 0, 12, 0),
          enabled: true,
          onLongPress: () => {},
          // onTap: () => Navigator.pushNamed(
          //   context,
          //   '/contactinfo',
          //   arguments: <String, int>{'id': index},
          // ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactInfoPage(id: index),
            ),
          ),
          title: Text(
            name,
            style: TextStyle(
                // color: Color(0xfff2f2f2),
                fontWeight: FontWeight.w700,
                fontSize: 17),
          ),
          subtitle: Text(
            message,
            // style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          trailing: ChatPreviewDetails(
            time: '3:${index.toString().padLeft(2, '0')} AM',
            statusIcon: Icons.check,
          ),
        ),
      ),
    );
  }
}

class ChatPreviewDetails extends StatelessWidget {
  ChatPreviewDetails({this.time, this.statusIcon});

  final String time;
  final IconData statusIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            time,
            // style: TextStyle(color: Colors.white54),
          ),
          Icon(
            statusIcon,
            size: 22,
            // color: Color(0xfff2f2f2),
          ),
        ],
      ),
    );
  }
}
