import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.person,
                  size: 30, color: Colors.grey), // Default profile icon
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getGreeting(),
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const Text(
                  'Charan BP',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.notifications_active,
              size: 30, color: Colors.yellow),
          onPressed: () {},
        ),
      ],
    );
  }
}
