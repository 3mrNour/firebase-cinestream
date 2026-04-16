import 'package:cinestream/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final CollectionReference _usersCollection = FirebaseFirestore.instance
      .collection('users');

  Future<void> addUser(UserModel user) async {
    await _usersCollection.doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'username': user.username,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'gender': user.gender,
      'image': user.image,
    });
  }

  Stream<QuerySnapshot> getUsers() {
    return _usersCollection.snapshots();
  }
}
