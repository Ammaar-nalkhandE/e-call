import 'package:flutter/material.dart';


class OxygenCalc extends StatefulWidget {
  @override
  _OxygenCalcState createState() => _OxygenCalcState();
}

class _OxygenCalcState extends State<OxygenCalc> {
  TextEditingController _hoursController = TextEditingController();
  TextEditingController _leafAreaController = TextEditingController();
  double _result = 0.0;

  void _calculate() {
    double leafArea = double.tryParse(_leafAreaController.text) ?? 0.0;

    // Calculation logic using the provided formula
    _result = 0.5 * leafArea *24; // Hourly Oxygen Production = 0.5 liters of O2/square meter/hour * 1 square meter

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaf Cleaning Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: _leafAreaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Leaf Area (sq. meters)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text(
              'Daily Oxygen Production: $_result liters of O2', // Display the result
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _leafAreaController.dispose();
    super.dispose();
  }
}