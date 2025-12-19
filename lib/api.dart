import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl =
      "https://nubbtodoapi.kode4u.tech/api";


  static Future<bool> register(String username, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "action": "register",
        "username": username,
        "password": password,
      }),
    );
    return res.statusCode == 200;
  }


  static Future<bool> login(String username, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth.php"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "action": "login",
        "username": username,
        "password": password,
      }),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", data["token"]);
      return true;
    }
    return false;
  }


  static Future<List> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final res = await http.get(
      Uri.parse("$baseUrl/todos.php"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
    return [];
  }

  
  static Future<bool> addTodo({
    required String title,
    required String description,
    required String date,
    required String priority,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final res = await http.post(
      Uri.parse("$baseUrl/todos.php"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "title": title,
        "description": description,
        "date": date,
        "priority": priority,
      }),
    );

    return res.statusCode == 200;
  }


  static Future<bool> deleteTodo(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    final res = await http.delete(
      Uri.parse("$baseUrl/todos.php"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"id": id}),
    );

    return res.statusCode == 200;
  }
}
