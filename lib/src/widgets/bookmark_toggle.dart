import 'package:flutter/material.dart';

class BookmarkToggle extends StatelessWidget {
  const BookmarkToggle({
    super.key,
    this.isBookmarked = false,
    required this.onBookmarkToggle,
  });

  final bool isBookmarked;
  final ValueChanged<bool> onBookmarkToggle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        onBookmarkToggle(!isBookmarked);
      },
      icon: Icon(
        isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      // icon: const Icon(Icons.bookmark_border_rounded),
    );
  }
}
