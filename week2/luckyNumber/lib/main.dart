import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Lucky Number',
      home: GuessNumber(),
    );
  }
}

class GuessNumber extends StatefulWidget {
  const GuessNumber({Key? key}) : super(key: key);

  @override
  State<GuessNumber> createState() => _GuessNumberState();
}

class _GuessNumberState extends State<GuessNumber> {
  final TextEditingController controller = TextEditingController();
  final FocusNode node = FocusNode();
  String resultText = '';
  String? text;
  String? error;
  bool enable = true;
  String guessButton = 'Guess';
  int secretNumber = -1;

  void _dialogBox(int guess) {
    showDialog<void>( // here
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('You guessed right'),
            content: Text('It was $guess'),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      secretNumber = -1;
                      resultText = '';
                    });
                  },
                  child: const Text('Try again')),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      secretNumber = -1;
                      enable = false;
                      guessButton = 'Reset';
                    });
                  },
                  child: const Text('Ok')),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Guess my number',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Text(
              "I'm thinking of a number between 1 and 100.",
              textScaleFactor: 1.9,
              textAlign: TextAlign.center,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: Text(
                "It's your turn to guess my number!",
                textScaleFactor: 1.3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text(
                resultText,
                textScaleFactor: 2,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            Card(
              elevation: 10.0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 80 / 100,
                height: MediaQuery.of(context).size.height * 25 / 100,
                child: Column(
                  children: <Widget>[
                    const Text(
                        'Try a number!',
                        textScaleFactor: 1.8,
                        style: TextStyle(color: Colors.grey),
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.all(14.0),
                      child: TextField(
                        enabled: enable,
                        focusNode: node,
                        controller: controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          errorText: error,
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(node);
                          if (guessButton == 'Reset') {
                            setState(() {
                              enable = true;
                              guessButton = 'Guess';
                              resultText = '';
                            });
                          } else {
                            final String value = controller.text;
                            final int? guess = int.tryParse(value);
                            controller.clear();
                            if (guess == null) {
                              setState(() {
                                error = 'Please enter a number';
                              });
                            } else {
                              setState(() {
                                error = null;
                                if (secretNumber == -1) {
                                  secretNumber = Random().nextInt(99) + 1;
                                }
                                if (secretNumber > guess) {
                                  resultText =
                                  'You tried $guess\n Try higher.';
                                } else {
                                  if (secretNumber < guess) {
                                    resultText =
                                    'You tried $guess\n  Try lower.';
                                  } else {
                                    resultText =
                                    'You tried $guess\n You guessed right.';
                                    _dialogBox(guess);
                                    FocusScope.of(context).unfocus();
                                  }
                                }
                              });
                            }
                          }
                        },
                        child: Text(guessButton),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
