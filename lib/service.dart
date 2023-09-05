import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_database/Item.dart';

class Services {
  List<Item> items = <Item>[];

  Future<List<Item>> fetchAlbum() async {
    http.Response response =
        await http.get(Uri.parse('http://43.240.11.169:4000/get'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      items = result.map((dynamic item) => Item.fromJson(item)).toList();
      return items;
      // return result.map((e) => Item.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> addData(String name) async {
    final apiUrl = Uri.parse('http://43.240.11.169:4000/insert');
    Map data = {'name': name};

    http.Response response = await http.post(apiUrl, body: data);
    if (response.body != null) {
      print('Response${response.statusCode}');
    } else {
      print('API call failed with status code');
    }
  }

  Future<void> updateData(String name, String id) async {
    final apiUrl = Uri.parse('http://43.240.11.169:4000/update');
    Map data = {'name': name, 'id': id};
    http.Response response = await http.put(apiUrl, body: data);
    if (response.body != null) {
      print('Response${response.body}');
      print('Response${response.statusCode}');
    } else {
      print('API call failed with status code');
    }
  }

  Future<void> deleteData(String id) async {
    final apiUrl = Uri.parse('http://43.240.11.169:4000/delete');
    Map data = {'id': id};
    http.Response response = await http.delete(apiUrl, body: data);
    if (response.body != null) {
      print('Response${response.body}');
      print('Response${response.statusCode}');
    } else {
      print('API call failed with status code');
    }
  }
}
