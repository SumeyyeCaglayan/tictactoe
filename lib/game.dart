// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'ai.dart';

class TicTacToe extends StatefulWidget {

  const TicTacToe({super.key});

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String resultMessage = '';
  List<int> winningTiles = [];
  int playerXScore = 0;
  int playerOScore = 0;
  int draws = 0;

  void handleTap(int index) {
    if (board[index] == '' && resultMessage == '') {
      setState(() {
        board[index] = currentPlayer;
        if (checkWinner()) {
          resultMessage = '$currentPlayer Kazandý!';
          if (currentPlayer == 'X') {
            playerXScore++;
          } else {
            playerOScore++;
          }
        } else if (!board.contains('')) {
          resultMessage = 'Berabere!';
          draws++;
        } else {
          currentPlayer = 'O';
          computerMove();
        }
      });
    }
  }

  void computerMove() {
    int bestMove = findBestMove(board, currentPlayer);
    if (bestMove != -1) {
      setState(() {
        board[bestMove] = currentPlayer;
        if (checkWinner()) {
          resultMessage = '$currentPlayer Kazandý!';
          if (currentPlayer == 'O') {
            playerOScore++;
          } else {
            playerXScore++;
          }
        } else if (!board.contains('')) {
          resultMessage = 'Berabere!';
          draws++;
        } else {
          currentPlayer = 'X';
        }
      });
    }
  }

  bool checkWinner() {
    int winner = evaluateWithTiles(board, winningTiles);
    return winner == 10 || winner == -10;
  }

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      resultMessage = '';
      winningTiles = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tic-Tac-Toe Oyunu',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "Calibri"),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetGame,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/pngcerceve.png'), // Arka plan resminin URL'si
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => handleTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: winningTiles.contains(index)
                          ? Colors.greenAccent.withOpacity(0.7)
                          : Colors.blueGrey.withOpacity(0.5),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: const TextStyle(fontSize: 40, color: Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              resultMessage,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: resetGame,
              icon: const Icon(Icons.refresh, color: Colors.white),
              label:
                  const Text('Oyunu Sýfýrla', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'X: $playerXScore  O: $playerOScore  Beraberlik: $draws',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
