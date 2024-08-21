import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final String subtitle;
  final String imageUrl;
  final VoidCallback onTap;

  const UserTile({
    required this.text,
    required this.subtitle,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(text),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}
