import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  Widget build(BuildContext buildContext) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primaryColor: Colors.grey,
      ),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 38;
  double resultFontSize = 48;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '0';
        result = '0';
      } else if (buttonText == '⌫') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') equation = '0';
      } else if (buttonText == '=') {
        expression = equation;
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('×', '*');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();

          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          equation = result;
        } catch (e) {
          result = 'Error';
        }
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '×' ||
          buttonText == '÷') {
        if (equation.substring(equation.length - 1, equation.length) == '+' ||
            equation.substring(equation.length - 1, equation.length) == '-' ||
            equation.substring(equation.length - 1, equation.length) == '×' ||
            equation.substring(equation.length - 1, equation.length) == '÷') {
          equation = equation.substring(0, equation.length - 1) + buttonText;
        } else {
          equation += buttonText;
        }
      } else {
        if (result.length >= 11) result = 'Too big number';

        if (equation == '0')
          equation = buttonText;
        else if (equation.length >= 11)
          equation = equation;
        else
          equation += buttonText;
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHight,
      color: buttonColor,
      child: TextButton(
        onPressed: () => buttonPressed(buttonText),
        style: TextButton.styleFrom(
            padding: EdgeInsets.all(16),
            primary: Colors.blueAccent,
            onSurface: Colors.black,
            side: BorderSide(color: Colors.black12, width: 5)),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.normal, color: Colors.white),
        ),
      ),
    );
  }

  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'C L C L T R',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Column(children: <Widget>[
        Container(
          color: Colors.black45,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(
            equation,
            style: TextStyle(fontSize: equationFontSize),
          ),
        ),
        Container(
          color: Colors.black38,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(
            result,
            style: TextStyle(fontSize: resultFontSize),
          ),
        ),
        Container(
          height: 74,
          color: Colors.black26,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        ),
        Container(
          height: 73,
          color: Colors.black12,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        ),
        Expanded(
          child: Divider(),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * .75,
            child: Table(
              children: [
                TableRow(children: [
                  buildButton('C', 1, Colors.black38),
                  buildButton('⌫', 1, Colors.black45),
                  buildButton('÷', 1, Colors.black54),
                ]),
                TableRow(children: [
                  buildButton('9', 1, Colors.black38),
                  buildButton('8', 1, Colors.black45),
                  buildButton('7', 1, Colors.black54),
                ]),
                TableRow(children: [
                  buildButton('4', 1, Colors.black38),
                  buildButton('5', 1, Colors.black45),
                  buildButton('6', 1, Colors.black54),
                ]),
                TableRow(children: [
                  buildButton('1', 1, Colors.black38),
                  buildButton('2', 1, Colors.black45),
                  buildButton('3', 1, Colors.black54),
                ]),
                TableRow(children: [
                  buildButton('.', 1, Colors.black38),
                  buildButton('0', 1, Colors.black45),
                  buildButton('00', 1, Colors.black54),
                ])
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Table(
              children: [
                TableRow(children: [
                  buildButton('×', 1, Colors.black87),
                ]),
                TableRow(children: [
                  buildButton('-', 1, Colors.black87),
                ]),
                TableRow(children: [
                  buildButton('+', 1, Colors.black87),
                ]),
                TableRow(children: [
                  buildButton('=', 2, Colors.black87),
                ]),
              ],
            ),
          )
        ]),
      ]),
    );
  }
}
