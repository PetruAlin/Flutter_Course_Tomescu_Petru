import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const NumberShapes(),
    );
  }
}

class NumberShapes extends StatefulWidget {
  const NumberShapes({Key? key}) : super(key: key);

  @override
  State<NumberShapes> createState() => _NumberShapesState();
}

class _NumberShapesState extends State<NumberShapes> {
  final TextEditingController controller = TextEditingController();
  final FocusNode node = FocusNode();
  String? error;

  void _dialogbox(int number, String dialogText) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('$number'),
            content: Text(dialogText),
          );
        }
    );
  }

  bool _checkSquare(int number) {
    int i = 0;
    bool result = false;
    while (i * i <= number) {
      if (i * i == number) {
        result = true;
      }
      i = i + 1;
    }
    return result;
  }

  bool _checkTriangle(int number) {
    int i = 0;
    bool result = false;
    while (i * i * i <= number) {
      if (i * i * i == number) {
        result = true;
      }
      i = i + 1;
    }
    return result;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Shapes"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
            child: Text(
              'Please input a number to see if it is square or triangular.',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: const EdgeInsetsDirectional.all(12.0),
            child: TextField(
              enabled: true,
              controller: controller,
              focusNode: node,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                errorText: error,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(node);
          final String value = controller.text;
          final int? number = int.tryParse(value);
          if (number == null) {
            setState(() {
              error = "Please enter a number";
              controller.clear();
            });
          } else {
            setState(() {
              error = null;
              String dialogText = '';
              controller.clear();
              if (_checkSquare(number)) {
                if (_checkTriangle(number)) {
                  dialogText = "Number $number is both SQUARE and TRIANGULAR.";
                } else {
                  dialogText = "Number $number is SQUARE.";
                }
              } else {
                if (_checkTriangle(number)) {
                  dialogText = "Number $number is TRIANGULAR.";
                } else {
                  dialogText =
                  "Number $number is neither TRIANGULAR or SQUARE.";
                }
              }
              _dialogbox(number, dialogText);
              FocusScope.of(context).unfocus();
            });
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
