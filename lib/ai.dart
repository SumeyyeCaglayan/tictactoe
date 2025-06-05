import 'dart:math';

int findBestMove(List<String> board, String currentPlayer) {
  int bestVal = -1000;
  int bestMove = -1;

  for (int i = 0; i < board.length; i++) {
    if (board[i] == '') {
      board[i] = currentPlayer;
      int moveVal = alphaBeta(board, 0, false, -1000, 1000);
      board[i] = '';
      if (moveVal > bestVal) {
        bestMove = i;
        bestVal = moveVal;
      }
    }
  }
  return bestMove;
}

int alphaBeta(List<String> board, int depth, bool isMax, int alpha, int beta) {
  int score = evaluate(board);

  if (score == 10) return score;
  if (score == -10) return score;
  if (!board.contains('')) return 0;

  if (isMax) {
    int best = -1000;
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        board[i] = 'O';
        best = max(best, alphaBeta(board, depth + 1, !isMax, alpha, beta));
        board[i] = '';
        alpha = max(alpha, best);
        if (beta <= alpha) break;
      }
    }
    return best;
  } else {
    int best = 1000;
    for (int i = 0; i < board.length; i++) {
      if (board[i] == '') {
        board[i] = 'X';
        best = min(best, alphaBeta(board, depth + 1, !isMax, alpha, beta));
        board[i] = '';
        beta = min(beta, best);
        if (beta <= alpha) break;
      }
    }
    return best;
  }
}

int evaluate(List<String> board) {
  List<List<int>> winningConditions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (var condition in winningConditions) {
    if (board[condition[0]] == board[condition[1]] &&
        board[condition[1]] == board[condition[2]]) {
      if (board[condition[0]] == 'O') {
        return 10;
      } else if (board[condition[0]] == 'X') {
        return -10;
      }
    }
  }
  return 0;
}

int evaluateWithTiles(List<String> board, List<int> winningTiles) {
  List<List<int>> winningConditions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (var condition in winningConditions) {
    if (board[condition[0]] == board[condition[1]] &&
        board[condition[1]] == board[condition[2]]) {
      if (board[condition[0]] != '') {
        winningTiles.addAll(condition);
        return board[condition[0]] == 'O' ? 10 : -10;
      }
    }
  }
  return 0;
}
