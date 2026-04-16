// import 'dart:convert';
// import 'package:cinestream/data/api/auth_client.dart';
// import 'package:cinestream/data/models/user_model.dart';
// import 'package:cinestream/screens/HomeScreen.dart';
// import 'package:dio/dio.dart' as dio;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthServises {
//   final AuthClient _authClient = AuthClient();

//   Future<UserModel?> login(
//     String username,
//     String Password,
//     BuildContext context,
//   ) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     try {
//       dio.Response loginresponse = await _authClient.postData(
//         '/auth/login',
//         body: {"username": username, "password": Password},
//       );

//       if (loginresponse.statusCode == 200 && loginresponse.data != null) {
//         UserModel userdata = UserModel.fromJson(loginresponse.data);
//         prefs.setBool("isLogin", true);
//         prefs.setString("userData", jsonEncode(userdata.toJson()));
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => HomeScreen()),
//         );

//         return userdata;
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//       return null;
//     }
//     return null;
//   }
// }
import 'package:cinestream/data/api/constants.dart';
import 'package:cinestream/data/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cinestream/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServises {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  final GoogleSignIn _googleSignIn = GoogleSignIn(serverClientId: serverClientId);

  Future<UserModel?> signup({
    required String emailAddress,
    required String password,
    required String fullName,
  }) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: emailAddress.trim(),
            password: password,
          );

      final firebaseUser = result.user;
      if (firebaseUser == null) {
        throw 'Registration failed. Please try again.';
      }

      final userModel = UserModel(
        uid: firebaseUser.uid,
        email: emailAddress.trim(),
        username: fullName.trim(),
        firstName: fullName.trim(),
        lastName: '',
        gender: '',
        image: '',
      );

      try {
        await FireStoreService().addUser(userModel);
      } catch (_) {
        await firebaseUser.delete();
        throw 'Failed to save user data. Please try again.';
      }

      return userModel;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak. Please use at least 6 characters.';
      } else if (e.code == 'email-already-in-use') {
        throw 'An account already exists for this email. Please login instead.';
      } else if (e.code == 'invalid-email') {
        throw 'The email address is invalid. Please check and try again.';
      } else if (e.code == 'operation-not-allowed') {
        throw 'Email/password accounts are not enabled. Please contact support.';
      } else {
        throw 'Registration failed: ${e.message ?? 'Unknown error occurred'}';
      }
    } catch (e) {
      throw 'An unexpected error occurred: $e';
    }
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final firebaseUser = result.user;
      if (firebaseUser == null) {
        throw 'Login failed. Please try again.';
      }

      final usersCollection = _firestore.collection('users');
      final userDoc = await usersCollection.doc(firebaseUser.uid).get();

      if (userDoc.exists && userDoc.data() != null) {
        return UserModel.fromJson(userDoc.data()!);
      }

      final legacyUserQuery = await usersCollection
          .where('email', isEqualTo: email.trim())
          .limit(1)
          .get();

      if (legacyUserQuery.docs.isNotEmpty &&
          legacyUserQuery.docs.first.data().isNotEmpty) {
        final legacyData = legacyUserQuery.docs.first.data();
        final repairedUser = UserModel(
          uid: firebaseUser.uid,
          email: legacyData['email']?.toString() ?? email.trim(),
          username: legacyData['username']?.toString() ?? '',
          firstName: legacyData['firstName']?.toString() ?? '',
          lastName: legacyData['lastName']?.toString() ?? '',
          gender: legacyData['gender']?.toString() ?? '',
          image: legacyData['image']?.toString() ?? '',
        );

        await usersCollection.doc(firebaseUser.uid).set(repairedUser.toJson());

        return repairedUser;
      }

      throw 'User profile data was not found. Please register again.';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw 'No user account found with this email. Please create an account first.';
        case 'wrong-password':
        case 'invalid-credential':
          throw 'Incorrect password. Please check and try again.';
        case 'invalid-email':
          throw 'The email address is invalid. Please check and try again.';
        case 'user-disabled':
          throw 'This user account has been disabled. Please contact support.';
        case 'too-many-requests':
          throw 'Too many login attempts. Please try again later.';
        default:
          throw 'Login failed: ${e.message ?? 'Unknown error occurred'}';
      }
    } catch (e) {
      throw 'An unexpected error occurred: $e';
    }
  }

  Future<UserModel?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw 'Google sign-in was cancelled.';
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential result =
          await _firebaseAuth.signInWithCredential(credential);

      final firebaseUser = result.user;
      if (firebaseUser == null) {
        throw 'Google sign-in failed. Please try again.';
      }

      final usersCollection = _firestore.collection('users');
      final userDoc = await usersCollection.doc(firebaseUser.uid).get();
      if (userDoc.exists && userDoc.data() != null) {
        return UserModel.fromJson(userDoc.data()!);
      }

      final fullName =
          firebaseUser.displayName?.trim().isNotEmpty == true
              ? firebaseUser.displayName!.trim()
              : (firebaseUser.email?.split('@').first ?? '').trim();

      final userModel = UserModel(
        uid: firebaseUser.uid,
        email: (firebaseUser.email ?? '').trim(),
        username: fullName,
        firstName: fullName,
        lastName: '',
        gender: '',
        image: '',
      );

      await usersCollection.doc(firebaseUser.uid).set(userModel.toJson());
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw 'Google sign-in failed: ${e.message ?? 'Unknown error occurred'}';
    } catch (e) {
      throw 'An unexpected error occurred: $e';
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
