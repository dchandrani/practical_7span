import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../search_movies.dart' show searchMoviesControllerProvider;

class SearchAppBar extends ConsumerStatefulWidget {
  const SearchAppBar({super.key});

  @override
  ConsumerState<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends ConsumerState<SearchAppBar> {
  late final TextEditingController _searchController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 10,
        right: 10,
        bottom: 8,
      ),
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10.0),
          const Icon(Icons.search_rounded),
          const SizedBox(width: 12.0),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _debounce?.cancel();
                  _debounce = Timer(
                    const Duration(milliseconds: 500),
                    () {
                      ref
                          .read(searchMoviesControllerProvider.notifier)
                          .searchMovies(value.trim());
                    },
                  );
                } else {
                  ref.read(searchMoviesControllerProvider.notifier).reset();
                }
              },
              cursorColor: Colors.grey,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontSize: 16.0,
              ),
              decoration: InputDecoration(
                hintText: 'Search movies',
                border: InputBorder.none,
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                contentPadding: const EdgeInsets.only(
                  top: 15.0,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        _searchController.clear();
                        ref
                            .read(searchMoviesControllerProvider.notifier)
                            .reset();
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
