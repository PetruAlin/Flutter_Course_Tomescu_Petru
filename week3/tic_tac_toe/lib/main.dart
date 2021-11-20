// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  final List<Nodes> _list = <Nodes>[];
  int player = 1;
  bool button = false;

  void _reset() {
    for (int i = 0; i < 9; i++) {
      final Nodes n = _list.firstWhere((Nodes item) => item.index == i);
      _list.remove(n);
      _list.add(Nodes(true, false, false, false, n.index));
    }
  }

  void _deactivate(Nodes n) {
    _list.remove(n);
    _list.add(Nodes(true, false, n.player1, n.player2, n.index));
  }

  bool _checkDraw() {
    int completed = 0;
    if (_list.length == 9) {
      for (int i = 0; i < 9; i++) {
        if ((!_list[i].player2 && _list[i].player1) || (!_list[i].player1 && _list[i].player2)) {
          completed++;
        }
      }
    }
    return completed == 9;
  }

  bool _checkWin() {
    if (_list.length == 9) {
      final Nodes el0 = _list.firstWhere((Nodes element) => element.index == 0);
      final Nodes el1 = _list.firstWhere((Nodes element) => element.index == 1);
      final Nodes el2 = _list.firstWhere((Nodes element) => element.index == 2);
      final Nodes el3 = _list.firstWhere((Nodes element) => element.index == 3);
      final Nodes el4 = _list.firstWhere((Nodes element) => element.index == 4);
      final Nodes el5 = _list.firstWhere((Nodes element) => element.index == 5);
      final Nodes el6 = _list.firstWhere((Nodes element) => element.index == 6);
      final Nodes el7 = _list.firstWhere((Nodes element) => element.index == 7);
      final Nodes el8 = _list.firstWhere((Nodes element) => element.index == 8);
      if (el0.player2 && el1.player2 && el2.player2 || el0.player1 && el1.player1 && el2.player1) {
        setState(() {
          _deactivate(el3);
          _deactivate(el4);
          _deactivate(el5);
          _deactivate(el6);
          _deactivate(el7);
          _deactivate(el8);
        });
        return true;
      }
      if (el3.player2 && el4.player2 && el5.player2 || el3.player1 && el4.player1 && el5.player1) {
        setState(() {
          _deactivate(el0);
          _deactivate(el1);
          _deactivate(el2);
          _deactivate(el6);
          _deactivate(el7);
          _deactivate(el8);
        });
        return true;
      }
      if (el6.player2 && el7.player2 && el8.player2 || el6.player1 && el7.player1 && el8.player1) {
        setState(() {
          _deactivate(el0);
          _deactivate(el1);
          _deactivate(el2);
          _deactivate(el3);
          _deactivate(el4);
          _deactivate(el5);
        });
        return true;
      }
      if (el0.player2 && el3.player2 && el6.player2 || el0.player1 && el3.player1 && el6.player1) {
        setState(() {
          _deactivate(el1);
          _deactivate(el2);
          _deactivate(el4);
          _deactivate(el5);
          _deactivate(el7);
          _deactivate(el8);
        });
        return true;
      }
      if (el1.player2 && el4.player2 && el7.player2 || el1.player1 && el4.player1 && el7.player1) {
        setState(() {
          _deactivate(el0);
          _deactivate(el2);
          _deactivate(el3);
          _deactivate(el5);
          _deactivate(el6);
          _deactivate(el8);
        });
        return true;
      }
      if (el2.player2 && el5.player2 && el8.player2 || el2.player1 && el5.player1 && el8.player1) {
        setState(() {
          _deactivate(el0);
          _deactivate(el1);
          _deactivate(el3);
          _deactivate(el4);
          _deactivate(el6);
          _deactivate(el7);
        });
        return true;
      }
      if (el2.player1 && el4.player1 && el6.player1 || el2.player2 && el4.player2 && el6.player2) {
        setState(() {
          _deactivate(el0);
          _deactivate(el1);
          _deactivate(el3);
          _deactivate(el5);
          _deactivate(el7);
          _deactivate(el8);
        });
        return true;
      }
      if (el0.player1 && el4.player1 && el8.player1 || el0.player2 && el4.player2 && el8.player2) {
        setState(() {
          _deactivate(el1);
          _deactivate(el2);
          _deactivate(el3);
          _deactivate(el5);
          _deactivate(el6);
          _deactivate(el7);
        });
        return true;
      }
    }
    return _checkDraw();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('tic tac toe'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 2.0,
                    crossAxisSpacing: 2.0,
                  ),
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {
                    final Nodes? square = _list.firstWhereOrNull((Nodes item) => item.index == index);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (!button) {
                            if (square == null) {
                              _list.add(Nodes(true, false, false, false, index));
                            }
                            if (square != null) {
                              if (player == 1) {
                                if (!square.player2 && !square.activated) {
                                  _list.remove(square);
                                  _list.add(Nodes(true, true, true, false, square.index));
                                  player = 2;
                                }
                              } else {
                                if (!square.player1 && !square.activated) {
                                  _list.remove(square);
                                  _list.add(Nodes(true, true, false, true, square.index));
                                  player = 1;
                                }
                              }
                            }
                            if (!button) {
                              button = _checkWin();
                            }
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        constraints: const BoxConstraints.expand(),
                        color: square != null
                            ? (square.activated &&
                                    ((square.player1 && !square.player2) || (square.player2 && !square.player1))
                                ? (square.player1 ? Colors.green : Colors.red)
                                : Colors.white)
                            : Colors.white,
                      ),
                    );
                  }),
            ),
          ),
          if (button)
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _reset();
                    button = false;
                  });
                },
                child: const Text('Play Again!'))
          else
            Container(),
        ],
      ),
    );
  }
}

class Nodes {
  Nodes(this.color, this.activated, this.player1, this.player2, this.index);

  final bool color;
  final bool activated;
  final bool player1;
  final bool player2;
  final int index;
}
