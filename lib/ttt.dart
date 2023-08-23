import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tic Tac Toe'),
        ),
        body: const Center(
          child: StartButton(),
        ),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({Key? key}) : super(key: key);

  void _startGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TicTacToeGame()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _startGame(context);
      },
      child: const Text('Start Tic Tac Toe'),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({Key? key}) : super(key: key);

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  List<List<String>> _board = List.generate(3, (_) => List.filled(3, ''));
  String _currentPlayer = 'X';
  String _winPlayer = '';
  List<dynamic> winList = List.generate(8, (i) => List.generate(3, (i)=> null));

  _TicTacToeGameState(){
    winList[0] = [[0,0],[0,1],[0,2]];
    winList[1] = [[1,0],[1,1],[1,2]];
    winList[2] = [[2,0],[2,1],[2,2]];
    winList[3] = [[0,0],[1,0],[2,0]];
    winList[4] = [[0,1],[1,1],[2,1]];
    winList[5] = [[0,2],[1,2],[2,2]];
    winList[6] = [[0,0],[1,1],[2,2]];
    winList[7] = [[0,2],[1,1],[2,0]];
  }

  void _resetGame(){
    setState(() {
      _currentPlayer = 'X';
      _board = List.generate(3, (_) => List.filled(3, ''));
      _winPlayer = '';
      Fluttertoast.showToast(msg: 'reset the Game!!');
    });
  }

  void _playMove(int row, int col) {
    setState(() {
      _board[row][col] = _currentPlayer;
      if(_isWinner() == 1){
        showDialog(
            context: context,
            //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                //Dialog Main Title
                title: Column(
                  children: <Widget>[
                    Text("Winner is $_winPlayer"),
                  ],
                ),
                //
                content: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Dialog Content",
                    ),
                  ],
                ),
                actions: <Widget>[
                  FloatingActionButton(
                    child: const Text("확인"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });
      }
    });
    _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
  }

  int _isWinner(){
    for(List<List<int>> list in winList){
      if(_board[list[0][0]][list[0][1]] != ''
          && _board[list[0][0]][list[0][1]] == _board[list[1][0]][list[1][1]]
          && _board[list[1][0]][list[1][1]] == _board[list[2][0]][list[2][1]] ){
        _winPlayer = _currentPlayer;
        return 1;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Player: $_currentPlayer'),
            const SizedBox(height: 16.0),
            Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 0.0,
                  crossAxisSpacing: 0.0,
                ),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  final row = index ~/ 3;
                  final col = index % 3;
                  return GestureDetector(
                    onTap: () {
                      if (_board[row][col].isEmpty && _winPlayer.isEmpty) {
                        _playMove(row, col);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                      ),
                      child: Center(
                        child: Text(_board[row][col]),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _resetGame();
              },
              child: const Text('reset Game'),
            ),
          ],
        ),
      ),
    );
  }
}