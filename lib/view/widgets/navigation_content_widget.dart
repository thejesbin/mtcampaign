import 'package:flutter/material.dart';

class NavigationContentWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const NavigationContentWidget(
      {super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 35,
        ),
        Icon(
          icon,
          color: Colors.black54,
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        )
      ],
    );
  }
}
