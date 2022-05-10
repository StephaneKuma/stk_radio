import 'package:flutter/material.dart';

import 'entry.dart';

class STKDrawer extends StatelessWidget {
  const STKDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text('STK RADIO'),
            accountEmail: Text('info@stkradio.tech'),
            currentAccountPicture: FlutterLogo(size: 42.0),
          ),
          Entry(
            iconData: Icons.home_outlined,
            text: 'Home',
            onTap: () {},
          ),
          Entry(
            iconData: Icons.star_border,
            text: 'Rate',
            onTap: () {},
          ),
          Entry(
            iconData: Icons.facebook_sharp,
            text: 'Facebook',
            onTap: () {},
          ),
          Entry(
            iconData: Icons.video_file,
            text: 'Youtube',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
