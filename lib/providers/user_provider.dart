import 'dart:convert';

import 'package:cinestream/data/models/user_model.dart';
import 'package:cinestream/data/services/auth_services.dart';
import 'package:cinestream/providers/navBar_provider.dart';
import 'package:cinestream/screens/HomeScreen.dart';
import 'package:cinestream/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  // Login form
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  bool _loginSecurePassword = true;

  // Register form
  final registerFormKey = GlobalKey<FormState>();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerFullNameController = TextEditingController();
  bool _registerSecurePassword = true;

  final AuthServises authServises = AuthServises();

  bool _isLoading = false;
  String _errorMessage = '';

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get loginSecurePassword => _loginSecurePassword;
  bool get registerSecurePassword => _registerSecurePassword;

  UserModel? userModel;

  void toggleLoginPassword() {
    _loginSecurePassword = !_loginSecurePassword;
    notifyListeners();
  }

  void toggleRegisterPassword() {
    _registerSecurePassword = !_registerSecurePassword;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    if (loginFormKey.currentState?.validate() ?? false) {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();
      try {
        final loggedInUser = await authServises.login(
          email: loginEmailController.text,
          password: loginPasswordController.text,
        );
        if (loggedInUser != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLogin', true);
          await prefs.setString('userData', jsonEncode(loggedInUser.toJson()));
          userModel = loggedInUser;
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        }
      } catch (e) {
        _errorMessage = e.toString();
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      final loggedInUser = await authServises.loginWithGoogle();
      if (loggedInUser != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLogin', true);
        await prefs.setString('userData', jsonEncode(loggedInUser.toJson()));
        userModel = loggedInUser;
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    if (registerFormKey.currentState?.validate() ?? false) {
      _isLoading = true;
      _errorMessage = '';
      notifyListeners();
      try {
        final registeredUser = await authServises.signup(
          emailAddress: registerEmailController.text,
          password: registerPasswordController.text,
          fullName: registerFullNameController.text,
        );
        if (registeredUser != null) {
          await authServises.signOut();
          if (context.mounted) {
            clearControllers();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account created successfully. Please log in.'),
              ),
            );
            Navigator.pop(context);
          }
        }
      } catch (e) {
        _errorMessage = e.toString();
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  UserProvider() {
    loadData();
  }
  Future<void> logout(BuildContext context) async {
    final navProvider = Provider.of<NavProvider>(context, listen: false);
    await authServises.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLogin');
    await prefs.remove('userData');
    await prefs.remove('favorite_movies');
    userModel = null;
    notifyListeners();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      navProvider.changeIndex(0);
    }
  }

  Future loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("userData");
    if (data != null) {
      dynamic da = jsonDecode(data);
      userModel = UserModel.fromJson(da);
      notifyListeners();
    } else {
      userModel = null;
    }
  }

  void clearControllers() {
    loginEmailController.clear();
    loginPasswordController.clear();
    registerEmailController.clear();
    registerPasswordController.clear();
    registerFullNameController.clear();
    _errorMessage = '';
    notifyListeners();
  }
}
