import 'package:flutter/material.dart';
import 'dart:math';


class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String val1 = "";
  String val2 = "";
  String optr = "";
  bool clk = false;
  TextEditingController ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: ctrl,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 50),
          _buildButtonRow(["AC", "%", "⌫", "+"], [Colors.red, Colors.grey, Colors.blue, Colors.orange]),
          _buildButtonRow(["7", "8", "9", "-"], [Colors.grey[800]!, Colors.grey[800]!, Colors.grey[800]!, Colors.orange]),
          _buildButtonRow(["4", "5", "6", "×"], [Colors.grey[800]!, Colors.grey[800]!, Colors.grey[800]!, Colors.orange]),
          _buildButtonRow(["1", "2", "3", "="], [Colors.grey[800]!, Colors.grey[800]!, Colors.grey[800]!, Colors.green]),
          _buildButtonRow(["0", "√", ".", "÷"], [Colors.grey[800]!, Colors.orange, Colors.grey[800]!, Colors.orange]),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> labels, List<Color> colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(labels.length, (index) {
          return _buildButton(labels[index], colors[index]);
        }),
      ),
    );
  }

  Widget _buildButton(String label, Color color) {
    return ElevatedButton(
      onPressed: () {
        _handleButtonPress(label);
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
        backgroundColor: color,
        elevation: 5,
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  void _handleButtonPress(String label) {
    setState(() {
      if (label == "AC") {
        val1 = "";
        val2 = "";
        ctrl.text = "";
        optr = "";
        clk = false;
      } else if (label == "⌫") {
        if (val1.isNotEmpty) {
          val1 = val1.substring(0, val1.length - 1);
          ctrl.text = val1;
        }
      } else if (label == "=") {
        _calculate();
      } else if (label == "+" || label == "-" || label == "×" || label == "÷" || label == "%" || label == "√") {
        optr = label;
        clk = true;
        ctrl.text = label;
      } else {
        if (clk) {
          val2 += label;
          ctrl.text = val2;
        } else {
          val1 += label;
          ctrl.text = val1;
        }
      }
    });
  }

  void _calculate() {
    double a = double.parse(val1);
    double b = val2.isNotEmpty ? double.parse(val2) : 0;
    double res = 0;

    switch (optr) {
      case "+":
        res = a + b;
        break;
      case "-":
        res = a - b;
        break;
      case "×":
        res = a * b;
        break;
      case "÷":
        res = b != 0 ? a / b : 0;
        break;
      case "%":
        res = a % b;
        break;
      case "√":
        res = a >= 0 ? sqrt(a) : 0;
        break;
    }
    ctrl.text = res.toString();
  }
}
