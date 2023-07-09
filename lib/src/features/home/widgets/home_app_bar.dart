import 'package:flutter/material.dart';

import '../../../routing/routing.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 4.0,
        top: MediaQuery.of(context).padding.top,
        bottom: 8.0,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Text(
            'TMDb App',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Nunito',
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                Routing.searchMoviesPage,
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
