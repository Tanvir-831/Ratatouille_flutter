import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';
import 'my_drawer.dart';

class MyRecipesPage extends StatefulWidget {
  @override
  _MyRecipesPageState createState() => _MyRecipesPageState();
}

class _MyRecipesPageState extends State<MyRecipesPage> {
  final FirestoreService _firestoreService = FirestoreService();
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  bool _isEditing = false;
  String? _editingId;

  Future<void> _addOrUpdateRecipe(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_isEditing && _editingId != null) {
        await _firestoreService.updateRecipe(_editingId!, _formData);
      } else {
        await _firestoreService.addRecipe(_formData);
      }
      _resetForm();
      Navigator.of(context).pop(); // Close the bottom sheet
    }
  }

  Future<void> _deleteRecipe(String id) async {
    await _firestoreService.deleteRecipe(id);
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _isEditing = false;
    _editingId = null;
    _formData.clear();
  }

  void _openForm(BuildContext context, [Map<String, dynamic>? recipe, String? id]) {
    if (recipe != null && id != null) {
      _formData.addAll(recipe);
      _isEditing = true;
      _editingId = id;
    }
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16.0,
          right: 16.0,
          top: 16.0,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 5,
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _isEditing ? 'Edit Recipe' : 'Add Recipe',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    _buildTextField('Item Name', 'name', icon: Icons.restaurant_menu),
                    _buildTextField('Category', 'category', icon: Icons.category),
                    _buildTextField(
                      'Calories',
                      'calories',
                      keyboardType: TextInputType.number,
                      icon: Icons.local_fire_department,
                    ),
                    _buildTextField('Ingredients', 'ingredients', icon: Icons.list),
                    _buildTextField('Time', 'time', icon: Icons.timer),
                    _buildTextField('Description', 'description', icon: Icons.description),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _addOrUpdateRecipe(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(_isEditing ? 'Update Recipe' : 'Add Recipe'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ).whenComplete(() {
      if (!_isEditing) _resetForm();
    });
  }

  Widget _buildTextField(
      String label,
      String key, {
        TextInputType keyboardType = TextInputType.text,
        required IconData icon,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: _formData[key]?.toString(),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        keyboardType: keyboardType,
        onSaved: (value) {
          if (keyboardType == TextInputType.number) {
            _formData[key] = int.tryParse(value ?? '') ?? 0;
          } else {
            _formData[key] = value;
          }
        },
        validator: (value) => value == null || value.isEmpty ? 'This field is required' : null,
      ),
    );
  }

  void _showDetails(Map<String, dynamic> recipe) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(recipe['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category: ${recipe['category']}'),
            Text('Calories: ${recipe['calories']}'),
            Text('Ingredients: ${recipe['ingredients']}'),
            Text('Time: ${recipe['time']}'),
            SizedBox(height: 8),
            Text('Description:'),
            Text(recipe['description']),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Recipes'),
        backgroundColor: Colors.blue.shade600,
      ),
      drawer: MyDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.recipeCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No recipes found.'));
          }

          final recipes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              final recipeData = recipe.data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Colors.blue.shade50,
                child: ListTile(
                  contentPadding: EdgeInsets.all(12),
                  title: Text(
                    recipeData['name'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${recipeData['category']} | ${recipeData['calories']} cal',
                    style: TextStyle(color: Colors.black54),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue.shade600),
                        onPressed: () => _openForm(context, recipeData, recipe.id),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red.shade600),
                        onPressed: () => _deleteRecipe(recipe.id),
                      ),
                    ],
                  ),
                  onTap: () => _showDetails(recipeData),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openForm(context),
        backgroundColor: Colors.blue.shade600,
        child: Icon(Icons.add),
      ),
    );
  }
}
