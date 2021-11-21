import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BasicPhrases(),
    );
  }
}

class BasicPhrases extends StatefulWidget {
  const BasicPhrases({Key? key}) : super(key: key);

  @override
  State<BasicPhrases> createState() => _BasicPhrasesState();
}

class _BasicPhrasesState extends State<BasicPhrases> {
  final List<String> _words = <String>[
    'Salut',
    'Salut [Franceza]',
    'Ce mai faci',
    'Ce mai faci [Franceza]',
    'Cati ani ai',
    'Cati ani ai [Franceza]',
    'La revedere',
    'La revedere [Franceza]',
    'Cum te numesti',
    'Cum te numesti [Franceza]',
  ];

  final List<String> _audio = <String>[
    r'assets\Salut.mp3',
    r'assets\Salut_F.mp3',
    r'assets\Ce_mai_faci.mp3',
    r'assets\Ce_mai_faci_F.mp3',
    r'assets\Cati_ani_ai.mp3',
    r'assets\Cati_ani_ai_F.mp3',
    r'assets\La_revedere.mp3',
    r'assets\La_revedere_F.mp3',
    r'assets\Cum_te_numesti.mp3',
    r'assets\Cum_te_numesti_F.mp3',
  ];

  final _player = AudioPlayer();

  Future<void> playAudio(String file) async {
    await _player.play(file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Phrases"),
        backgroundColor: Colors.blueAccent,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        itemCount: _words.length,
        itemBuilder: (BuildContext context, int index) {
          final String element = _words.firstWhere((element) => _words.indexOf(element) == index);
          return GestureDetector(
            onTap: () {
              setState(() {
                int i = _words.indexOf(element);
                playAudio(_audio[i]);
              });
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              constraints: const BoxConstraints.expand(),
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  element,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
