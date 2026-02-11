import 'package:flutter/material.dart';

class BlaInput extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Widget? trailing;

  const BlaInput({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey.shade600),
            const SizedBox(width: 14),

            Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),

            trailing ?? const Spacer(),
          ],
        ),
      ),
    );
  }
}
