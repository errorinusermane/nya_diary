import 'package:flutter/material.dart';

class CustomAboutDialog extends StatelessWidget {
  const CustomAboutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: color.surface,
      contentPadding: const EdgeInsets.all(30),
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'NYA DIARY',
          style: textStyle.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color.secondary,
          ),
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '버전: v1.0.0',
              style: textStyle.bodyMedium?.copyWith(
                color: color.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 13),
            Text(
              'Made by Susie 🐾',
              style: textStyle.bodyMedium?.copyWith(
                color: color.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('nya'),
        ),
      ],
    );
  }
}
