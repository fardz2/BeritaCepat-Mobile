import 'dart:convert';

import 'package:berita_mobile/services/user_check.dart';
import 'package:http/http.dart' as http;

const API_URL = "https://amused-mayfly-ace.ngrok-free.app";

class ApiService {
  final client = http.Client();
  final user_check = UserCheck();
  Future<Map<String, dynamic>> getBerita() async {
    final url = Uri.parse('$API_URL/api/news');
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["data"];
      } else {
        throw Exception("Failed to get berita");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getCategory() async {
    final url = Uri.parse('$API_URL/api/category');
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception("Failed to get categories");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getDetailCategory(String slug) async {
    final url = Uri.parse('$API_URL/api/category/$slug');
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["data"];
      } else {
        throw Exception("Failed to get categories");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> getDetail(String slug) async {
    final url = Uri.parse('$API_URL/api/news/$slug');
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["data"];
      } else {
        throw Exception("Failed to get berita");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> searchNews(String search) async {
    final url = Uri.parse('$API_URL/api/search?berita=$search');

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final listNews = data["data"];
        return listNews;
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> createComment(String slug, String comment) async {
    final url = Uri.parse('$API_URL/api/news/$slug/comment');
    try {
      await client.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${user_check.box.read("token")}',
          },
          body: jsonEncode(<String, dynamic>{
            'comment': comment,
          }));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse('$API_URL/api/login');
    try {
      final response = await client.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'email': email,
            'password': password,
          }));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        user_check.box.write("token", data["token"]);
      } else {
        throw Exception("Failed to get berita");
      }
    } catch (e) {}
  }

  Future<void> register(String name, String email, String password) async {
    final url = Uri.parse('$API_URL/api/register');
    try {
      await client.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'name': name,
            'email': email,
            'password': password,
          }));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> logout() async {
    final url = Uri.parse('$API_URL/api/logout');
    try {
      final response = await client.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${user_check.box.read("token")}',
        },
      );
      if (response.statusCode == 200) {
        user_check.box.remove("token");
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
