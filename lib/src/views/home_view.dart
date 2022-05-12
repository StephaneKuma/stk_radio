import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../locator/locator.dart';
import '../services/button_service.dart';
import '../widgets/play_button.dart';
import '../widgets/stk_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _tryAgain = false;
  late StreamSubscription<InternetConnectionStatus> _statusSubscription;

  _checkConnectionState() async {
    _statusSubscription = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      final hasInternet = status == InternetConnectionStatus.connected;

      if (!hasInternet) {
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.ERROR,
          title: 'No Internet Connection',
          desc: 'Please check your connectivity',
          btnOkOnPress: () {},
        ).show();
      }

      if (_tryAgain != !hasInternet) {
        setState(() {
          _tryAgain = !hasInternet;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _checkConnectionState();
    getIt<ButtonService>().init();
  }

  @override
  void dispose() {
    _statusSubscription.cancel();
    getIt<ButtonService>().dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/background.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('STK RADIO'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('App link in playstore'),
                  ),
                );
              },
              icon: const Icon(Icons.share),
            ),
          ],
        ),
        drawer: const STKDrawer(),
        body: Center(
          child: _tryAgain
              ? ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Verifying Network State'),
                      ),
                    );
                    _checkConnectionState();
                  },
                  child: const Text('Try Again'),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const Spacer(),
                    Container(
                      height: MediaQuery.of(context).size.width * .5,
                      width: MediaQuery.of(context).size.width * .5,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Now Playing',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32.0,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: const <Widget>[
                        PlayButton(),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
