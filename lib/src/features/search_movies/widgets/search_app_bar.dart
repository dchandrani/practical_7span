import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../search_movies.dart'
    show SearchStatus, searchMoviesControllerProvider;

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
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
              decoration: InputDecoration(
                hintText: 'Search movies',
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Consumer(
                      builder: (context, ref, child) {
                        final searchState =
                            ref.watch(searchMoviesControllerProvider);

                        if (searchState.status == SearchStatus.searching) {
                          return const Row(
                            children: [
                              SizedBox(width: 10.0),
                              Center(
                                child: SizedBox(
                                  height: 18.0,
                                  width: 18.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(Colors.grey),
                                    strokeWidth: 2.0,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
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
