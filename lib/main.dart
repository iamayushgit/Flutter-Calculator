import 'package:app1/color.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MaterialApp(
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {

  //variables
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

onButtonClick(value){
 
 //if value is AC
 if(value == "AC"){
  input = '';
  output = '';
 }
 else if(value == "<"){
  if(input.isNotEmpty){

  input = input.substring(0, input.length - 1);
  }
 }
 else if(value == "="){
  if(input.isNotEmpty){

  var userInput = input;
  userInput = input.replaceAll("x", "*");
  Parser p = Parser();
  Expression expression = p.parse(userInput);
  ContextModel cm = ContextModel();
  var finalValue = expression.evaluate(EvaluationType.REAL, cm);
  output = finalValue.toString();
  if(output.endsWith(".0")){
      output = output.substring(0, output.length - 2);
  }
  input = output;
  hideInput = true;
  outputSize = 52;


  }
 }
 else{
  input = input + value;
  hideInput = false;
  outputSize = 34;
 }

 setState(() {
   
 });


}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //input output area
          Expanded(
              child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                  Text(
                  hideInput ? '' : input,
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
               const SizedBox(
                  height: 40,
                ),
                Text(
                  output,
                  style: TextStyle(
                      fontSize: outputSize, color: Colors.white.withOpacity(0.7)),
                ),
              const  SizedBox(
                  height: 20,
                )
              ],
            ),
          )),
          //buttons area
          Row(
            children: [
              button(
                  text: "AC",
                  buttonBgColor: operatorColor,
                  tColor: orangeColor),
              button(
                  text: "<", buttonBgColor: operatorColor, tColor: orangeColor),
              button(text: "", buttonBgColor: Colors.transparent),
              button(
                  text: "/", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "7", buttonBgColor: operatorColor),
              button(text: "8", buttonBgColor: operatorColor),
              button(text: "9", buttonBgColor: operatorColor),
              button(
                  text: "x", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "4", buttonBgColor: operatorColor),
              button(text: "5", buttonBgColor: operatorColor),
              button(text: "6", buttonBgColor: operatorColor),
              button(
                  text: "/", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(text: "1", buttonBgColor: operatorColor),
              button(text: "2", buttonBgColor: operatorColor),
              button(text: "3", buttonBgColor: operatorColor),
              button(
                  text: "+", buttonBgColor: operatorColor, tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              button(
                  text: "%", buttonBgColor: operatorColor, tColor: orangeColor),
              button(text: "0", buttonBgColor: operatorColor),
              button(
                  text: ".", buttonBgColor: operatorColor, tColor: orangeColor),
              button(text: "=", buttonBgColor: orangeColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(22),
            backgroundColor: buttonBgColor,
          ),
          onPressed: () => onButtonClick(text) ,
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18, color: tColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
