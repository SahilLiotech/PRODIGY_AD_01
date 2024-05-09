import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";
  final List<String> buttons = [
    'C', '(', ')' ,'/',
    '7', '8', '9', '*',
    '4', '5', '6', '+',
    '1', '2', '3', '-',
    'AC', '0', '.', '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Calculator"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              // flex: 1,
                child: resultWidget(),
            ),
            Expanded(flex:2,
              child: _buttons(
              ),
            ),
          ],
        ),
      ) ,
      drawer: const Drawer(),
    );
  }

  Widget resultWidget(){
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            child: Text(
              userInput,
              style:const TextStyle(fontSize: 32),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget _buttons() {
    return GridView.builder(
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
      itemBuilder: (BuildContext context, int index) {
        return _myButton(buttons[index]);
      },
      itemCount: buttons.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }

  _myButton(String text) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: MaterialButton(
        onPressed: () {
          setState(() {
           handelButtonTap(text);
          });
        },
        shape: const CircleBorder(),
        color: _getColor(text),
        textColor: Colors.white,
        child: Text(
          text,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  handelButtonTap(String text){
    if(text == "AC"){
      userInput = "";
      result = "0";
      return;
    }

    if(text == "C"){
      userInput = userInput.substring(0,userInput.length-1);
      return;
    }

    if (text == "="){
      try {
        Parser p = Parser();
        Expression exp = p.parse(userInput);
          result = '${exp.evaluate(EvaluationType.REAL, ContextModel())}';
          result.toString();
        if (result.endsWith(".0")) {
          result = result.replaceAll(".0", "");
        }
      }
      catch(e){
        result = "error $e";
    }
    userInput = "";
    return;
    }

    userInput = userInput + text;
  }

  _getColor(String text) {
    if (text == "/" || text == "*" || text == "+" || text == "-") {
      return Theme.of(context).colorScheme.secondary;
    }
    if (text == "C" || text == "AC") {
      return Colors.lightGreen;
    }
    if (text == "(" || text == ")") {
      return Colors.blueGrey;
    }
    return Theme.of(context).colorScheme.primary;
  }
}