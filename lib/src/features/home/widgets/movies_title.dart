import 'package:flutter/material.dart';

class MoviesTitle extends StatelessWidget {
  const MoviesTitle({
    super.key,
    required this.title,
    required this.onViewAllTap,
  });

  final String title;
  final VoidCallback onViewAllTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Spacer(),
        TextButton(
          onPressed: onViewAllTap,
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          child: const Text('View All'),
        ),
      ],
    );
  }
}
