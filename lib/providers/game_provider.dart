import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_state.dart';
import '../models/block.dart';

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier();
});

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier() : super(GameState.initial()) {
    _loadHighScore();
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    final highScore = prefs.getInt('highScore') ?? 0;
    state = state.copyWith(highScore: highScore);
  }

  Future<void> _saveHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('highScore', score);
  }

  void placeBlock(int row, int col, Block block) {
    // Validate placement
    if (_canPlaceBlock(row, col, block)) {
      // Place block
      final newGrid = List<List<int>>.from(state.grid);
      for (var offset in block.shape) {
        int r = row + offset.dy.toInt();
        int c = col + offset.dx.toInt();
        newGrid[r][c] = 1; // Occupied
      }

      HapticFeedback.lightImpact();

      // Clear lines
      final clearedLines = _clearLines(newGrid);
      final newScore = state.score + clearedLines * 10;

      if (clearedLines > 0) {
        HapticFeedback.vibrate();
      }

      // Update high score if needed
      int newHighScore = state.highScore;
      if (newScore > state.highScore) {
        newHighScore = newScore;
        _saveHighScore(newHighScore);
      }

      // Generate new blocks
      final newBlocks = Block.getRandomBlocks().take(3).toList();

      // Check game over
      bool gameOver = !_canPlaceAnyBlock(newGrid, newBlocks);
      if (gameOver) {
        // Handle game over, maybe show dialog or reset
        // For now, just reset
        resetGame();
        return;
      }

      state = state.copyWith(
        grid: newGrid,
        score: newScore,
        highScore: newHighScore,
        availableBlocks: newBlocks,
      );
    }
  }

  bool _canPlaceBlock(int row, int col, Block block) {
    for (var offset in block.shape) {
      int r = row + offset.dy.toInt();
      int c = col + offset.dx.toInt();
      if (r < 0 || r >= 8 || c < 0 || c >= 8 || state.grid[r][c] != 0) {
        return false;
      }
    }
    return true;
  }

  bool _canPlaceAnyBlock(List<List<int>> grid, List<Block> blocks) {
    for (int r = 0; r < 8; r++) {
      for (int c = 0; c < 8; c++) {
        for (var block in blocks) {
          if (_canPlaceBlockAt(r, c, block, grid)) {
            return true;
          }
        }
      }
    }
    return false;
  }

  bool _canPlaceBlockAt(int row, int col, Block block, List<List<int>> grid) {
    for (var offset in block.shape) {
      int r = row + offset.dy.toInt();
      int c = col + offset.dx.toInt();
      if (r < 0 || r >= 8 || c < 0 || c >= 8 || grid[r][c] != 0) {
        return false;
      }
    }
    return true;
  }

  int _clearLines(List<List<int>> grid) {
    int cleared = 0;

    // Clear rows
    for (int i = 0; i < 8; i++) {
      if (grid[i].every((cell) => cell == 1)) {
        grid[i] = List.generate(8, (_) => 0);
        cleared++;
      }
    }

    // Clear columns
    for (int j = 0; j < 8; j++) {
      bool full = true;
      for (int i = 0; i < 8; i++) {
        if (grid[i][j] == 0) full = false;
      }
      if (full) {
        for (int i = 0; i < 8; i++) {
          grid[i][j] = 0;
        }
        cleared++;
      }
    }

    return cleared;
  }

  void resetGame() {
    state = GameState.initial().copyWith(highScore: state.highScore);
  }
}