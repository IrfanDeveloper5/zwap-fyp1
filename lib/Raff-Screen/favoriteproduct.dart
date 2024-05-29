import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> toggleFavoriteProduct(String userId, String productId) async {
    DocumentReference userRef = _firestore.collection('users').doc(userId);
    DocumentSnapshot userDoc = await userRef.get();
    
    List<dynamic> favoriteProducts = userDoc['favoriteProducts'] ?? [];
    
    if (favoriteProducts.contains(productId)) {
      // Remove from favorites
      userRef.update({
        'favoriteProducts': FieldValue.arrayRemove([productId])
      });
    } else {
      // Add to favorites
      userRef.update({
        'favoriteProducts': FieldValue.arrayUnion([productId])
      });
    }
  }

  Future<List<Map<String, dynamic>>> fetchFavoriteProducts(String userId) async {
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
    List<dynamic> favoriteProductIds = userDoc['favoriteProducts'] ?? [];
    
    List<Map<String, dynamic>> favoriteProducts = [];
    
    for (String productId in favoriteProductIds) {
      DocumentSnapshot productDoc = await _firestore.collection('products').doc(productId).get();
      if (productDoc.exists) {
        favoriteProducts.add(productDoc.data() as Map<String, dynamic>);
      }
    }
    return favoriteProducts;
  }
}
class FavoriteProductsScreen extends StatefulWidget {
  final String userId;

  FavoriteProductsScreen({required this.userId});

  @override
  _FavoriteProductsScreenState createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  late Future<List<Map<String, dynamic>>> _favoriteProducts;

  @override
  void initState() {
    super.initState();
    _favoriteProducts = FavoriteService().fetchFavoriteProducts(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Products'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _favoriteProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading favorites'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorite products found'));
          }

          List<Map<String, dynamic>> favoriteProducts = snapshot.data!;

          return ListView.builder(
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              var product = favoriteProducts[index];
              return Card(
                child: ListTile(
                  leading: Image.network(product['imageUrls'][0]),
                  title: Text(product['title']),
                  subtitle: Text(product['description']),
                  trailing: IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () async {
                      await FavoriteService().toggleFavoriteProduct(widget.userId, product['id']);
                      setState(() {
                        _favoriteProducts = FavoriteService().fetchFavoriteProducts(widget.userId);
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}












// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: FavoriteProductsScreen(userId: 'user123'), // replace with actual user ID
//     );
//   }
// }

// class FavoriteService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> toggleFavoriteProduct(String userId, String productId) async {
//     DocumentReference userRef = _firestore.collection('users').doc(userId);
//     DocumentSnapshot userDoc = await userRef.get();
    
//     List<dynamic> favoriteProducts = userDoc['favoriteProducts'] ?? [];
    
//     if (favoriteProducts.contains(productId)) {
//       userRef.update({
//         'favoriteProducts': FieldValue.arrayRemove([productId])
//       });
//     } else {
//       userRef.update({
//         'favoriteProducts': FieldValue.arrayUnion([productId])
//       });
//     }
//   }

//   Future<List<Map<String, dynamic>>> fetchFavoriteProducts(String userId) async {
//     DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
//     List<dynamic> favoriteProductIds = userDoc['favoriteProducts'] ?? [];
    
//     List<Map<String, dynamic>> favoriteProducts = [];
    
//     for (String productId in favoriteProductIds) {
//       DocumentSnapshot productDoc = await _firestore.collection('products').doc(productId).get();
//       if (productDoc.exists) {
//         favoriteProducts.add(productDoc.data() as Map<String, dynamic>);
//       }
//     }
//     return favoriteProducts;
//   }
// }

// class FavoriteProductsScreen extends StatefulWidget {
//   final String userId;

//   FavoriteProductsScreen({required this.userId});

//   @override
//   _FavoriteProductsScreenState createState() => _FavoriteProductsScreenState();
// }

// class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
//   late Future<List<Map<String, dynamic>>> _favoriteProducts;

//   @override
//   void initState() {
//     super.initState();
//     _favoriteProducts = FavoriteService().fetchFavoriteProducts(widget.userId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Favorite Products'),
//       ),
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _favoriteProducts,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error loading favorites'));
//           }
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No favorite products found'));
//           }

//           List<Map<String, dynamic>> favoriteProducts = snapshot.data!;

//           return ListView.builder(
//             itemCount: favoriteProducts.length,
//             itemBuilder: (context, index) {
//               var product = favoriteProducts[index];
//               return Card(
//                 child: ListTile(
//                   leading: Image.network(product['imageUrls'][0]),
//                   title: Text(product['title']),
//                   subtitle: Text(product['description']),
//                   trailing: IconButton(
//                     icon: Icon(Icons.favorite, color: Colors.red),
//                     onPressed: () async {
//                       await FavoriteService().toggleFavoriteProduct(widget.userId, product['id']);
//                       setState(() {
//                         _favoriteProducts = FavoriteService().fetchFavoriteProducts(widget.userId);
//                       });
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

