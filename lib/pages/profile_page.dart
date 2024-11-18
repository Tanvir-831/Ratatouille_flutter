import 'package:flutter/material.dart';
import 'package:recipe/services/firestore_service.dart';
import 'my_drawer.dart'; // Import your custom drawer

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirestoreService _firestoreService = FirestoreService();

  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _numberController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    var userData = await _firestoreService.getUserData();
    if (userData != null) {
      setState(() {
        _nameController.text = userData['fullName'] ?? '';
        _nicknameController.text = userData['nickname'] ?? '';
        _numberController.text = userData['phoneNumber'] ?? '';
        _ageController.text = userData['age'] ?? '';
      });
    }
  }

  Future<void> _updateUserData() async {
    await _firestoreService.updateUserData(
      fullName: _nameController.text.trim(),
      nickname: _nicknameController.text.trim(),
      phoneNumber: _numberController.text.trim(),
      age: _ageController.text.trim(),
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.indigo.shade700,
      ),
      drawer: MyDrawer(), // Use the custom drawer
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Profile",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade700,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _nicknameController,
                decoration: InputDecoration(
                  labelText: 'Nickname',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  prefixIcon: Icon(Icons.tag),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _numberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                  prefixIcon: Icon(Icons.cake),
                ),
              ),
              SizedBox(height: 32),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _updateUserData,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      backgroundColor: Colors.indigo.shade700, // Background color for the button
                    ),
                    child: Text(
                      'Update Profile',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
