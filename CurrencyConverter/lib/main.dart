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
      title: 'Currency App',
      home: Currency(),
    );
  }
}

class Currency extends StatefulWidget {
  const Currency({Key? key}) : super(key: key);

  @override
  _CurrencyState createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  final TextEditingController controller = TextEditingController();
  String? text;
  String lei = '';
  String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Currency Converter',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Image.network('https://storage0.dms.mpinteractiv.ro/media/1/1481/22466/19093585/1/76459788-l.jpg?width=600'),
          Center(
            child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsetsDirectional.all(14.0),
                    child: TextField(
                      enabled: true,
                      controller: controller,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Enter the amount in EUR',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorText: error,
                        enabledBorder: const UnderlineInputBorder (
                          borderSide: BorderSide(
                              color: Colors.blue,
                              width: 1.0,
                              style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
            ),
          ),
          ElevatedButton(
              onPressed: () {
                final String value = controller.text;
                final double? euroValue = double.tryParse(value);
                if (euroValue == null) {
                  setState(() {
                    error = "Please enter a number";
                    lei = '';
                  });
                } else {
                  setState(() {
                    error = null;
                    lei = (euroValue * 4.5).toStringAsFixed(2) + ' RON';
                  });
                }
                //FocusScope.of(context).requestFocus(FocusNode());
              },
              child: const Text('Convert')
          ),
          Text(
            lei,
            textScaleFactor: 1.5,
          ),
        ],
      ),
    );
  }
}
