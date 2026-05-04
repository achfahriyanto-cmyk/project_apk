import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';

class Header extends ConsumerWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.blueGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('High Score: ${gameState.highScore}', style: const TextStyle(color: Colors.white, fontSize: 18)),
          Text('Score: ${gameState.score}', style: const TextStyle(color: Colors.white, fontSize: 18)),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              // Menu logic, e.g., show dialog for reset
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Menu'),
                  content: const Text('Reset game?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        ref.read(gameProvider.notifier).resetGame();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}