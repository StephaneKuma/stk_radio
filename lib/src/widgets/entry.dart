import 'package:flutter/material.dart';

class Entry extends StatelessWidget {
  const Entry({
    Key? key,
    required this.iconData,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final IconData iconData;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(text),
      onTap: onTap,
    );
  }
}
