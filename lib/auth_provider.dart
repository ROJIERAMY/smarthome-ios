import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref('users');
  
  User? _user;
  String? _token;
  String? _userRole;
  Map<String, dynamic>? _userData;
  
  User? get user => _user;
  bool get isAuthenticated => _user != null;
  String? get userRole => _userRole;
  Map<String, dynamic>? get userData => _userData;
  bool get isAdmin => _userRole == 'admin';

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      if (user != null) {
        _loadUserData();
      } else {
        _userRole = null;
        _userData = null;
      }
      notifyListeners();
    });
  }

  Future<void> _loadUserData() async {
    if (_user == null) return;
    
    try {
      final snapshot = await _database
          .orderByChild('uid')
          .equalTo(_user!.uid)
          .get();
      
      if (snapshot.exists) {
        final userData = snapshot.value as Map<dynamic, dynamic>;
        final user = userData.values.first as Map<dynamic, dynamic>;
        _userData = Map<String, dynamic>.from(user);
        _userRole = user['role'] ?? 'user';
      } else {
        _userRole = 'user';
        _userData = {
          'name': _user!.displayName ?? 'User',
          'email': _user!.email,
          'uid': _user!.uid,
          'role': 'user',
        };
      }
    } catch (e) {
      print('Error loading user data: $e');
      _userRole = 'user';
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      // Try to sign in with Firebase Auth directly
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        _user = userCredential.user;
        _token = await userCredential.user!.getIdToken();
        
        // Load user data and role
        await _loadUserData();
        
        // Save token to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', _token!);
        
        notifyListeners();
        return true;
      }
      
      return false;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      // Handle specific error codes
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
        case 'invalid-credential':
          return false; // User not registered or wrong credentials
        default:
          return false;
      }
    } catch (e) {
      print('Login Error: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      // Create user with Firebase Auth
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Save user data to Firebase Database
        await _database.push().set({
          'name': name,
          'email': email,
          'uid': userCredential.user!.uid,
          'role': 'user', // Default role
          'createdAt': ServerValue.timestamp,
        });

        _user = userCredential.user;
        _token = await userCredential.user!.getIdToken();
        
        // Load user data and role
        await _loadUserData();
        
        // Save token to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', _token!);
        
        notifyListeners();
        return {'success': true, 'message': 'Registration successful!'};
      }
      
      return {'success': false, 'message': 'Registration failed'};
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      String errorMessage = 'Registration failed';
      
      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'This email is already registered. Please use a different email.';
          break;
        case 'invalid-email':
          errorMessage = 'Please enter a valid email address.';
          break;
        case 'weak-password':
          errorMessage = 'Password is too weak. Please use at least 6 characters.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'Email/Password authentication is not enabled. Please contact support.';
          break;
        default:
          errorMessage = 'Registration failed: ${e.message}';
      }
      
      return {'success': false, 'message': errorMessage};
    } catch (e) {
      print('Registration Error: $e');
      return {'success': false, 'message': 'Registration failed: $e'};
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _user = null;
    _token = null;
    _userRole = null;
    _userData = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    notifyListeners();
  }
}