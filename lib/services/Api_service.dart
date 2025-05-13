import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "http://localhost:8080/api";

  Future<Map<String, dynamic>?> register(String username, String email, String password) async {
    final response = await http.post(Uri.parse('$apiUrl/auth/signup'),
      headers: {
        'Content-Type': 'application/json'
      },
      body:
        jsonEncode({
          'username': username,
          'email': email,
          'password': password
        })
    );
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else{
      return null;
    }
  }

  Future<Map<String, dynamic>?> login(String email, String password) async{
    final response = await http.post(Uri.parse('$apiUrl/auth/signin'),
        headers: {
          'Content-Type': 'application/json'
        },
        body:
          jsonEncode({
            'email': email,
            'password': password
          })
    );
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }
    else{
      return null;
    }
  }
  
  Future<Map<String, dynamic>?> me() async{
    final response = await http.get(Uri.parse('$apiUrl/me'));
    if(response.statusCode == 200) return jsonDecode(response.body);
    return null;
  }
}