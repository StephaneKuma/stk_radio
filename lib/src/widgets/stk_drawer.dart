import 'package:flutter/material.dart';

import '../helpers/page_transition.dart';
import '../locator/locator.dart';
import '../services/launcher_service.dart';
import '../views/home_view.dart';
import 'entry.dart';

class STKDrawer extends StatelessWidget {
  const STKDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text('STK RADIO'),
            accountEmail: const Text('info@stkradio.tech'),
            currentAccountPicture: Image.asset(
              'assets/logo.png',
              width: 42.0,
              height: 42.0,
            ),
          ),
          Entry(
            iconData: Icons.home_outlined,
            text: 'Home',
            onTap: () {
              Navigator.of(context).push(
                PageTransition(
                  child: const HomeView(),
                ),
              );
            },
          ),
          Entry(
            iconData: Icons.star_border,
            text: 'Rate',
            onTap: () {},
          ),
          Entry(
            iconData: Icons.facebook_sharp,
            text: 'Facebook',
            onTap: () {
              getIt<LauncherService>()
                  .openInBrowser(url: 'https:://facebook.com');
            },
          ),
          Entry(
            iconData: Icons.video_file,
            text: 'Youtube',
            onTap: () {
              getIt<LauncherService>()
                  .openInBrowser(url: 'https:://youtube.com');
            },
          ),
        ],
      ),
    );
  }
}
