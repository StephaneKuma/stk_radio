import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../widgets/play_button.dart';
import '../widgets/stk_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _tryAgain = false;
  bool _hasInternet = false;
  ConnectivityResult _result = ConnectivityResult.none;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late StreamSubscription<InternetConnectionStatus> _statusSubscription;

  _checkConnectionState() async {
    _statusSubscription = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      final hasInternet = status == InternetConnectionStatus.connected;

      if (hasInternet) {
        setState(() => _hasInternet = hasInternet);
      }

      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        title: 'No Internet Connection',
        desc: 'Please check your connectivity',
        btnOkOnPress: () {},
      ).show();

      if (_tryAgain != !hasInternet) {
        setState(() {
          _tryAgain = !hasInternet;
        });
      }
    });

    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() => _result = result);
    });
  }

  @override
  void initState() {
    super.initState();

    _checkConnectionState();
  }

  @override
  void dispose() {
    _statusSubscription.cancel();
    _connectivitySubscription.cancel();

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
          title: const Text('STK RADIO'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Share.share(
                  'check out my website https://stkservices.tech',
                  subject: 'STK RADIO!',
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
