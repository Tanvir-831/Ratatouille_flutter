import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'my_drawer.dart';

class MealNotePage extends StatefulWidget {
  @override
  _MealNotePageState createState() => _MealNotePageState();
}

class _MealNotePageState extends State<MealNotePage> {
  final _formKey = GlobalKey<FormState>();

  String? _category;
  String? _item;
  String? _date;
  String? _time;

  final _firestore = FirebaseFirestore.instance;

  void _showAddMealForm([DocumentSnapshot? doc]) {
    if (doc != null) {
      _category = doc['category'];
      _item = doc['item'];
      _date = doc['date'];
      _time = doc['time'];
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
                  decoration: InputDecoration(
                    labelText: 'Category',
                    prefixIcon: Icon(Icons.category),
                  ),
                  onChanged: (value) => _category = value,
                  validator: (value) =>
                  value == null ? 'Please select a category' : null,
                ),
                TextFormField(
                  initialValue: _item,
                  decoration: InputDecoration(
                    labelText: 'Item',
                    prefixIcon: Icon(Icons.fastfood),
                  ),
                  onChanged: (value) => _item = value,
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter an item' : null,
                ),
                TextFormField(
                  controller: TextEditingController(text: _date),
                  decoration: InputDecoration(
                    labelText: 'Date',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _date != null
                          ? DateTime.parse(_date!)
                          : DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _date =
                        '${selectedDate.toLocal()}'.split(' ')[0]; // YYYY-MM-DD
                      });
                    }
                  },
                  validator: (value) =>
                  value!.isEmpty ? 'Please select a date' : null,
                ),
                TextFormField(
                  initialValue: _time,
                  decoration: InputDecoration(
                    labelText: 'Time',
                    prefixIcon: Icon(Icons.access_time),
                  ),
                  onChanged: (value) => _time = value,
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter the time' : null,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final data = {
                        'category': _category!,
                        'item': _item!,
                        'date': _date!,
                        'time': _time!,
                      };
                      if (doc != null) {
                        await _firestore
                            .collection('meal_notes')
                            .doc(doc.id)
                            .update(data);
                      } else {
                        await _firestore.collection('meal_notes').add(data);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(doc != null ? 'Update Note' : 'Add Note'),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('meal_notes').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final mealNotes = snapshot.data!.docs;
          return mealNotes.isEmpty
              ? Center(
            child: Text(
              'No meal notes yet. Click the + button to add one!',
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          )
              : ListView.builder(
            itemCount: mealNotes.length,
            itemBuilder: (context, index) {
              final doc = mealNotes[index];
              return Card(
                margin:
                EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('${doc['item']} (${doc['category']})'),
                  subtitle: Text('${doc['date']} - ${doc['time']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _showAddMealForm(doc),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _firestore
                              .collection('meal_notes')
                              .doc(doc.id)
                              .delete();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
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
