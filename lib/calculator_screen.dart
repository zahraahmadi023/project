import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'cal_botton.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late int firstNum = 0;
  late int secondNum = 0;
  String history = '';
  String textToDisplay = '';
  late String res;
  late String operation = '';

  void btnOnClick(String bnVal) {
    if (bnVal == "AC") {
      setState(() {
        textToDisplay = "";
        firstNum = 0;
        secondNum = 0;
        res = "";
        operation = "";
      });
      return;
    }

    if (bnVal == "C") {
      setState(() {
        if (textToDisplay.isNotEmpty) {
          textToDisplay = textToDisplay.substring(0, textToDisplay.length - 1);
        }
      });
      return;
    }

    if (bnVal == "=") {
      if (operation.isNotEmpty && textToDisplay.isNotEmpty) {
        secondNum = int.tryParse(textToDisplay) ?? 0;
        switch (operation) {
          case '+':
            res = (firstNum + secondNum).toString();
            break;
          case '-':
            res = (firstNum - secondNum).toString();
            break;
          case '*':
            res = (firstNum * secondNum).toString();
            break;
          case '/':
            res = secondNum != 0
                ? (firstNum / secondNum).toStringAsFixed(2)
                : "Error";
            break;
        }
        setState(() {
          history = "$firstNum $operation $secondNum = $res";
          textToDisplay = res;
          operation = "";
        });
      }
      return;
    }

    if (['+', '-', '*', '/'].contains(bnVal)) {
      if (textToDisplay.isNotEmpty) {
        firstNum = int.tryParse(textToDisplay) ?? 0;
        setState(() {
          operation = bnVal;
          textToDisplay = "";
          history = "$firstNum $operation";
        });
      }
      return;
    }

    setState(() {
      textToDisplay += bnVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFDAD2FF),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.go('/home');
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: const Text(
          "Calculator",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF7886C7),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: screenWidth < 500 ? double.infinity : 500,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        history,
                        style: TextStyle(fontSize: 32, color: Colors.black45),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        textToDisplay,
                        style: TextStyle(fontSize: 48, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 2, color: Colors.black45),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CalcButton(
                                    text: "C",
                                    fillColor: 0xFF7886C7,
                                    callback: btnOnClick),
                                CalcButton(
                                    text: "/",
                                    fillColor: 0xFF7886C7,
                                    callback: btnOnClick),
                                CalcButton(
                                    text: "-",
                                    fillColor: 0xFF7886C7,
                                    callback: btnOnClick),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CalcButton(
                                    text: "7",
                                    fillColor: 0xFF493D9E,
                                    callback: btnOnClick),
                                CalcButton(
                                    text: "8",
                                    fillColor: 0xFF493D9E,
                                    callback: btnOnClick),
                                CalcButton(
                                    text: "9",
                                    fillColor: 0xFF493D9E,
                                    callback: btnOnClick),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CalcButton(
                                    text: "4",
                                    fillColor: 0xFF493D9E,
                                    callback: btnOnClick),
                                CalcButton(
                                    text: "5",
                                    fillColor: 0xFF493D9E,
                                    callback: btnOnClick),
                                CalcButton(
                                    text: "6",
                                    fillColor: 0xFF493D9E,
                                    callback: btnOnClick),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CalcButton(
                                    text: "1",
                                    fillColor: 0xFF493D9E,
                                    callback: btnOnClick),
                                CalcButton(
                                    text: "2",
                                    fillColor: 0xFF493D9E,
                                    callback: btnOnClick),
                                CalcButton(
                                    text: "3",
                                    fillColor: 0xFF493D9E,
                                    callback: btnOnClick),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CalcButton(
                                    text: "AC",
                                    fillColor: 0xFF7886C7,
                                    textSize: 24,
                                    callback: btnOnClick),
                                CalcButton(
                                    text: "0",
                                    fillColor: 0xFF493D9E,
                                    textSize: 24,
                                    callback: btnOnClick),
                                CalcButton(
                                    text: ".",
                                    fillColor: 0xFF493D9E,
                                    textSize: 24,
                                    callback: btnOnClick),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CalcButton(
                              text: "*",
                              fillColor: 0xFF7886C7,
                              textSize: 30,
                              callback: btnOnClick,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: CalcButton(
                              text: "+",
                              fillColor: 0xFF7886C7,
                              textSize: 36,
                              callback: btnOnClick,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: CalcButton(
                              text: "=",
                              fillColor: 0xFF7886C7,
                              textSize: 36,
                              callback: btnOnClick,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
