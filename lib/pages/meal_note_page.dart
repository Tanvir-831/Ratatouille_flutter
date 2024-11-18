import 'package:flutter/material.dart';
import 'my_drawer.dart';

class MealNotePage extends StatefulWidget {
  @override
  _MealNotePageState createState() => _MealNotePageState();
}

class _MealNotePageState extends State<MealNotePage> {
  final List<Map<String, String>> _mealNotes = [];
  final _formKey = GlobalKey<FormState>();

  String? _category;
  String? _item;
  String? _date; // Store date here
  String? _time;

  void _showAddMealForm([int? index]) {
    // If editing, prefill the form with existing data
    if (index != null) {
      final note = _mealNotes[index];
      _category = note['category'];
      _item = note['item'];
      _date = note['date']; // Store date
      _time = note['time'];
    } else {
      _category = null;
      _item = null;
      _date = null;
      _time = null;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: _category,
                  items: ['Breakfast', 'Lunch', 'Snacks', 'Dinner']
                      .map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  ))
                      .toList(),
                  decoration: InputDecoration(labelText: 'Category'),
                  onChanged: (value) => _category = value,
                  validator: (value) => value == null ? 'Please select a category' : null,
                ),
                TextFormField(
                  initialValue: _item,
                  decoration: InputDecoration(labelText: 'Item'),
                  onChanged: (value) => _item = value,
                  validator: (value) => value!.isEmpty ? 'Please enter an item' : null,
                ),
                // Replaced description field with date field
                TextFormField(
                  controller: TextEditingController(text: _date), // Use controller to set text
                  decoration: InputDecoration(labelText: 'Date'),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode()); // Hide keyboard
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _date != null ? DateTime.parse(_date!) : DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _date = '${selectedDate.toLocal()}'.split(' ')[0]; // Format as YYYY-MM-DD
                      });
                    }
                  },
                  validator: (value) => value!.isEmpty ? 'Please select a date' : null,
                ),
                TextFormField(
                  initialValue: _time,
                  decoration: InputDecoration(labelText: 'Time'),
                  onChanged: (value) => _time = value,
                  validator: (value) => value!.isEmpty ? 'Please enter the time' : null,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        if (index != null) {
                          // Update existing note
                          _mealNotes[index] = {
                            'category': _category!,
                            'item': _item!,
                            'date': _date!,
                            'time': _time!,
                          };
                        } else {
                          // Add new note
                          _mealNotes.add({
                            'category': _category!,
                            'item': _item!,
                            'date': _date!,
                            'time': _time!,
                          });
                        }
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text(index != null ? 'Update Note' : 'Add Note'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Note'),
        backgroundColor: Colors.blue.shade600,
      ),
      drawer: MyDrawer(),
      body: _mealNotes.isEmpty
          ? Center(
        child: Text(
          'No meal notes yet. Click the + button to add one!',
          style: TextStyle(fontSize: 18, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      )
          : ListView.builder(
        itemCount: _mealNotes.length,
        itemBuilder: (context, index) {
          final note = _mealNotes[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text('${note['item']} (${note['category']})'),
              subtitle: Text('${note['date']} - ${note['time']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _showAddMealForm(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _mealNotes.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMealForm(),
        backgroundColor: Colors.blue.shade600,
        child: Icon(Icons.add),
      ),
    );
  }
}
