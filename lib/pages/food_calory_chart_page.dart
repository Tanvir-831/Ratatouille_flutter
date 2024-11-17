import 'package:flutter/material.dart';
import 'my_drawer.dart';

class FoodCaloryChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Calory Chart'),
        backgroundColor: Colors.blue.shade600,
      ),
      drawer: MyDrawer(), // Add the drawer here
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.blue.shade50, // Light blue background for the page
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: SingleChildScrollView(
              child: DataTable(
                headingRowColor:
                MaterialStateProperty.all(Colors.blue.shade700),
                dataRowColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.blue.shade100;
                    }
                    return Colors.white; // Default row color
                  },
                ),
                dataRowHeight: 50,
                headingRowHeight: 60,
                columnSpacing: 20,
                border: TableBorder(
                  horizontalInside: BorderSide(
                    color: Colors.blue.shade200,
                    width: 1,
                  ),
                ),
                columns: [
                  DataColumn(
                    label: Text(
                      'Food (100g)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Calories',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Fat (g)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Protein (g)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Carbs (g)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Fiber (g)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
                rows: _getFoodCaloryData().map((food) {
                  return DataRow(
                    cells: [
                      DataCell(Text(
                        food['Food'],
                        style: TextStyle(fontSize: 14),
                      )),
                      DataCell(Text(
                        food['Calories'].toString(),
                        style: TextStyle(fontSize: 14),
                      )),
                      DataCell(Text(
                        food['Fat'].toString(),
                        style: TextStyle(fontSize: 14),
                      )),
                      DataCell(Text(
                        food['Protein'].toString(),
                        style: TextStyle(fontSize: 14),
                      )),
                      DataCell(Text(
                        food['Carbs'].toString(),
                        style: TextStyle(fontSize: 14),
                      )),
                      DataCell(Text(
                        food['Fiber'].toString(),
                        style: TextStyle(fontSize: 14),
                      )),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFoodCaloryData() {
    return [
      {'Food': 'Pecans', 'Calories': 691, 'Fat': 72, 'Protein': 9, 'Carbs': 14, 'Fiber': 10},
      {'Food': 'Walnuts', 'Calories': 654, 'Fat': 65, 'Protein': 15, 'Carbs': 14, 'Fiber': 7},
      {'Food': 'Hazelnuts', 'Calories': 628, 'Fat': 61, 'Protein': 15, 'Carbs': 17, 'Fiber': 10},
      {'Food': 'Sunflower Seeds', 'Calories': 584, 'Fat': 51, 'Protein': 21, 'Carbs': 20, 'Fiber': 9},
      {'Food': 'Almonds', 'Calories': 575, 'Fat': 49, 'Protein': 21, 'Carbs': 22, 'Fiber': 12},
      {'Food': 'Sesame Seeds', 'Calories': 573, 'Fat': 51, 'Protein': 18, 'Carbs': 23, 'Fiber': 12},
      {'Food': 'Pumpkin Seeds', 'Calories': 559, 'Fat': 50, 'Protein': 30, 'Carbs': 10, 'Fiber': 6},
      {'Food': 'Soybeans', 'Calories': 446, 'Fat': 20, 'Protein': 36, 'Carbs': 30, 'Fiber': 9},
      {'Food': 'Quinoa', 'Calories': 368, 'Fat': 6, 'Protein': 14, 'Carbs': 64, 'Fiber': 7},
      {'Food': 'Black Beans', 'Calories': 341, 'Fat': 1, 'Protein': 22, 'Carbs': 62, 'Fiber': 15},
      {'Food': 'Avocado', 'Calories': 160, 'Fat': 15, 'Protein': 2, 'Carbs': 9, 'Fiber': 7},
      {'Food': 'Garlic', 'Calories': 149, 'Fat': 0, 'Protein': 6, 'Carbs': 33, 'Fiber': 2},
      {'Food': 'Bananas', 'Calories': 89, 'Fat': 0, 'Protein': 1, 'Carbs': 23, 'Fiber': 3},
      {'Food': 'Corn', 'Calories': 86, 'Fat': 1, 'Protein': 3, 'Carbs': 19, 'Fiber': 2},
    ];
  }
}
