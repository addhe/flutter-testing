import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  // Store JWT token
  static const String _tokenKey = 'jwt_token';
  
  // Your backend API URL
  static const String _apiUrl = 'YOUR_API_URL';

  // Sign in with Google
  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Send Google token to your backend to get JWT
      final response = await http.post(
        Uri.parse('$_apiUrl/auth/google'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'token': googleAuth.idToken,
        }),
      );

      if (response.statusCode == 200) {
        final String token = json.decode(response.body)['token'];
        // Store JWT token
        await _saveToken(token);
        return token;
      }
      
      return null;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _removeToken();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  // Save JWT token to SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Get stored JWT token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Remove stored JWT token
  Future<void> _removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null;
  }
}
