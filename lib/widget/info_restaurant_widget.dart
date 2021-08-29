import 'package:flutter/material.dart';

class InfoRestaurant extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;

  const InfoRestaurant({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        SizedBox(
          width: 8,
        ),
        Text("$text"),
      ],
    );
  }
}
