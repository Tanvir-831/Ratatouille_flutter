import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteProvider with ChangeNotifier {
  final Set<String> _favorites = {}; // Store document IDs of favorites

  bool isExist(DocumentSnapshot<Object?> documentSnapshot) {
    return _favorites.contains(documentSnapshot.id);
  }

  void toggleFavorite(DocumentSnapshot<Object?> documentSnapshot) {
    final docId = documentSnapshot.id;
    if (_favorites.contains(docId)) {
      _favorites.remove(docId);
      updateFavoriteStatus(docId, false);
    } else {
      _favorites.add(docId);
      updateFavoriteStatus(docId, true);
    }
    notifyListeners();
  }

  void updateFavoriteStatus(String docId, bool isFavorite) {
    FirebaseFirestore.instance
        .collection('recipes')
        .doc(docId)
        .update({'isFavorite': isFavorite});
  }

  void loadFavorites(List<QueryDocumentSnapshot<Object?>> documents) {
    for (var doc in documents) {
      if (doc['isFavorite'] == true) {
        _favorites.add(doc.id);
      }
    }
    notifyListeners();
  }
}
