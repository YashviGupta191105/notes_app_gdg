import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../core/constants.dart';

class NoteFab extends StatelessWidget {
  final VoidCallback onPressed;

  const NoteFab({
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: primary,
      child: const FaIcon(FontAwesomeIcons.plus),
    );
  }
}

