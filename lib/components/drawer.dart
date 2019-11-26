import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import '../theming/theme_screen.dart';
import '../pages/new_chat.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 11,
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        // color: const Color(0xff3a5387),
        child: ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            DrawerProfile(),
            //
            DrawerItem(
                text: 'New Group',
                icon: Icons.people_outline,
                action: () => Navigator.pushNamed(context, '/newchat')),
            DrawerItem(
                text: 'New Secret Chat',
                icon: OMIcons.lock,
                action: () => Navigator.pushNamed(context, '/newchat')),
            DrawerItem(
                text: 'New Channel',
                icon: OMIcons.speakerNotes,
                action: () => Navigator.pushNamed(context, '/newchat')),
            DrawerItem(
                text: 'Contacts',
                icon: OMIcons.personOutline,
                action: () => Navigator.pushNamed(context, '/contactinfo')),
            DrawerItem(
                text: 'Calls',
                icon: OMIcons.call,
                action: () => Navigator.pushNamed(context, '/contactinfo')),
            DrawerItem(
                text: 'Saved Messages',
                icon: OMIcons.bookmarkBorder,
                action: () => Navigator.pushNamed(context, '/newchat')),
            DrawerItem(
                text: 'Settings',
                icon: OMIcons.settings,
                action: () => Navigator.pushNamed(context, '/settings')),
            //
            Divider(color: const Color(0xffa2a2a2), height: 14.0),
            //
            DrawerItem(
              text: 'Themes',
              icon: OMIcons.timelapse,
              action: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThemeScreen(),
                ),
              ),
            ),
            DrawerItem(
              text: 'Telegram FAQ',
              icon: OMIcons.liveHelp,
              action: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewChatPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  DrawerItem({this.text, this.icon, this.action});

  final String text;
  final IconData icon;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: const Color(0xff3a5387),
      child: InkWell(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(
            vertical: 1.0,
            horizontal: 20.0,
          ),
          dense: true,
          leading: Icon(
            icon,
            size: 27.0,
            // color: const Color(0xfff2f2f2),
          ),
          title: Text(
            text,
            style: TextStyle(
              // color: const Color(0xfff2f2f2),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          onTap: () => action(),
          onLongPress: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

class DrawerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: AlignmentDirectional.bottomStart,
      children: <Widget>[
        SizedBox(
          height: 170.0,
          width: double.infinity,
          // child: Image(
          //   fit: BoxFit.fitWidth,
          //   image: NetworkImage(
          //       'https://c.tadst.com/gfx/750x500/barcelona-morning-sky.jpg?1'),
          // ),
        ),
        Positioned(
          bottom: 64.0,
          left: 20.0,
          child: Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('images/profile_10.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(const Radius.circular(50.0)),
            ),
          ),
        ),
        Positioned(
            bottom: 10.0,
            left: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Dan',
                  style: TextStyle(
                    fontSize: 15.0,
                    // color: Colors.blue[300],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '+380 (98) 330 88 47',
                  style: TextStyle(
                    fontSize: 13.0,
                    // color: Colors.white70,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
