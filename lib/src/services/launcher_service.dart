import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

@lazySingleton
class LauncherService {
  void openInBrowser({required String url}) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) throw 'Could not launch $uri';
  }
}
