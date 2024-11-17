import 'package:flutter/material.dart';
import 'my_drawer.dart';

class MyBmiPage extends StatefulWidget {
  @override
  _MyBmiPageState createState() => _MyBmiPageState();
}

class _MyBmiPageState extends State<MyBmiPage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightFeetController = TextEditingController();
  final TextEditingController _heightInchesController = TextEditingController();

  double _bmi = 0;
  String _classification = '';
  String _message = '';

  void _calculateBMI() {
    final weight = double.tryParse(_weightController.text) ?? 0;
    final heightFeet = double.tryParse(_heightFeetController.text) ?? 0;
    final heightInches = double.tryParse(_heightInchesController.text) ?? 0;
    final totalHeightInInches = (heightFeet * 12) + heightInches;

    if (weight > 0 && totalHeightInInches > 0) {
      final heightInMeters = totalHeightInInches * 0.0254;
      setState(() {
        _bmi = weight / (heightInMeters * heightInMeters);

        if (_bmi < 18.5) {
          _classification = 'Underweight';
          _message = 'You may need to gain some weight. Consider a balanced diet.';
        } else if (_bmi < 24.9) {
          _classification = 'Normal';
          _message = 'Great job! Maintain your current lifestyle.';
        } else if (_bmi < 29.9) {
          _classification = 'Overweight';
          _message = 'Time to consider some exercise and healthier eating.';
        } else {
          _classification = 'Obese';
          _message = 'Consider a diet plan and regular exercise to stay healthy.';
        }
      });
    }
  }

  void _resetFields() {
    setState(() {
      _weightController.clear();
      _heightFeetController.clear();
      _heightInchesController.clear();
      _bmi = 0;
      _classification = '';
      _message = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Mass Index Calculator'),
        backgroundColor: Colors.blue.shade600,
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'BODY MASS INDEX CALCULATOR',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 30),
            _buildInputField('Weight (lbs)', _weightController),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildInputField('Height (ft)', _heightFeetController)),
                SizedBox(width: 15),
                Expanded(child: _buildInputField('Height (in)', _heightInchesController)),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _resetFields,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade300, // Light blue for reset
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: Text(
                    'RESET',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  onPressed: _calculateBMI,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade400, // Light blue for calculate
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: Text(
                    'CALCULATE',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            if (_bmi > 0) ...[
              Text(
                'Your BMI is: ${_bmi.toStringAsFixed(1)}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Classification: $_classification',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _classification == 'Obese'
                      ? Colors.red
                      : (_classification == 'Normal' ? Colors.green : Colors.orange),
                ),
              ),
              SizedBox(height: 10),
              Text(
                _message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
