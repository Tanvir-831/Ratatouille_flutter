import 'package:flutter/material.dart';
import 'my_drawer.dart';

class CaloryCalculator extends StatefulWidget {
  @override
  _CaloryCalculatorState createState() => _CaloryCalculatorState();
}

class _CaloryCalculatorState extends State<CaloryCalculator> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightFeetController = TextEditingController();
  final TextEditingController heightInchesController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String gender = "male";
  String activityLevel = "sedentary";
  String result = "";

  void calculateCalories() {
    int age = int.tryParse(ageController.text) ?? 0;
    int heightFeet = int.tryParse(heightFeetController.text) ?? 0;
    int heightInches = int.tryParse(heightInchesController.text) ?? 0;
    int weight = int.tryParse(weightController.text) ?? 0;

    if (age > 0 && heightFeet > 0 && weight > 0) {
      // Convert height to inches
      int totalHeightInches = (heightFeet * 12) + heightInches;

      // Calculate Basal Metabolic Rate (BMR) using the Harris-Benedict formula
      double bmr;
      if (gender == "male") {
        bmr = 66 + (6.23 * weight) + (12.7 * totalHeightInches) - (6.8 * age);
      } else {
        bmr = 655 + (4.35 * weight) + (4.7 * totalHeightInches) - (4.7 * age);
      }

      // Adjust BMR based on activity level
      double activityMultiplier;
      switch (activityLevel) {
        case "sedentary":
          activityMultiplier = 1.2;
          break;
        case "light":
          activityMultiplier = 1.375;
          break;
        case "moderate":
          activityMultiplier = 1.55;
          break;
        case "active":
          activityMultiplier = 1.725;
          break;
        case "very_active":
          activityMultiplier = 1.9;
          break;
        default:
          activityMultiplier = 1.2;
      }

      double calorieNeeds = bmr * activityMultiplier;

      setState(() {
        result =
        "Your daily calorie needs are approximately ${calorieNeeds.toStringAsFixed(0)} kcal.";
      });
    } else {
      setState(() {
        result = "Please fill out all fields correctly.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calory Calculator'),
        backgroundColor: Colors.blue.shade600,
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter Your Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Age Field
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Gender Selection
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text("Male"),
                    value: "male",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text("Female"),
                    value: "female",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                ),
              ],
            ),

            // Height Inputs
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: heightFeetController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Height (Feet)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: heightInchesController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Height (Inches)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Weight Input
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Weight (lbs)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // Activity Level Dropdown
            DropdownButtonFormField<String>(
              value: activityLevel,
              decoration: InputDecoration(
                labelText: "Activity Level",
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(value: "sedentary", child: Text("Sedentary")),
                DropdownMenuItem(value: "light", child: Text("Light exercise")),
                DropdownMenuItem(
                    value: "moderate", child: Text("Moderate exercise")),
                DropdownMenuItem(value: "active", child: Text("Active")),
                DropdownMenuItem(value: "very_active", child: Text("Very Active")),
              ],
              onChanged: (value) {
                setState(() {
                  activityLevel = value!;
                });
              },
            ),
            SizedBox(height: 16),

            // Calculate Button
            Center(
              child: ElevatedButton(
                onPressed: calculateCalories,
                child: Text("Calculate"),
              ),
            ),

            SizedBox(height: 16),

            // Result Section
            if (result.isNotEmpty)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
