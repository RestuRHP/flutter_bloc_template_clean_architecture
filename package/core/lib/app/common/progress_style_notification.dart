import 'package:flutter/material.dart';

class ProgressStyleNotification extends StatefulWidget {
  final double progress;
  const ProgressStyleNotification({super.key, required this.progress});

  @override
  State<ProgressStyleNotification> createState() => _ProgressStyleNotificationState();
}

class _ProgressStyleNotificationState extends State<ProgressStyleNotification> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 200.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        Positioned(
          left: widget.progress * 200.0,
          child: const Icon(Icons.star, color: Colors.yellow),
        ),
      ],
    );
  }
}

