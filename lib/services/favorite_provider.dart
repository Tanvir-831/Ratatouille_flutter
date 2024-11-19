import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<String> _favoriteIds = []; // Stores favorite item IDs
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> get favorites => _favoriteIds; // Getter for favorites

  // Constructor to load favorites from Firestore on initialization
  FavoriteProvider() {
    loadFavorites();
  }

  /// Toggle favorite state of a product
  void toggleFavorite(DocumentSnapshot product) async {
    String productId = product.id;
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId); // Remove from local favorites
      await _removeFavorite(productId); // Remove from Firestore
    } else {
      _favoriteIds.add(productId); // Add to local favorites
      await _addFavorite(productId); // Add to Firestore
    }
    notifyListeners(); // Notify listeners for UI update
  }

  /// Check if a product is favorited
  bool isExist(DocumentSnapshot product) {
    return _favoriteIds.contains(product.id);
  }

  /// Add favorite to Firestore
  Future<void> _addFavorite(String productId) async {
    try {
      await _firestore.collection("userFavorite").doc(productId).set({
        'isFavorite': true, // Marks the item as favorite in Firestore
      });
    } catch (e) {
      print("Error adding favorite: $e");
    }
  }

  /// Remove favorite from Firestore
  Future<void> _removeFavorite(String productId) async {
    try {
      await _firestore.collection("userFavorite").doc(productId).delete();
    } catch (e) {
      print("Error removing favorite: $e");
    }
  }

  /// Load all favorite items from Firestore
  Future<void> loadFavorites() async {
    try {
      QuerySnapshot snapshot =
      await _firestore.collection("userFavorite").get();
      _favoriteIds.clear(); // Clear old data
      _favoriteIds.addAll(snapshot.docs.map((doc) => doc.id).toList());
    } catch (e) {
      print("Error loading favorites: $e");
    }
    notifyListeners();
  }

  /// Static helper to access the provider from any widget
  static FavoriteProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}