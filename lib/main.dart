// ignore_for_file: camel_case_types
import 'dart:convert';
import 'package:api_database/Item.dart';
import 'package:api_database/service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  runApp(const MaterialApp(
    home: Api_Database(),
  ));
}

class Api_Database extends StatefulWidget {
  const Api_Database({super.key});

  @override
  State<Api_Database> createState() => _Api_DatabaseState();
}

class _Api_DatabaseState extends State<Api_Database> {
  TextEditingController nameController = TextEditingController();
  Services service = Services();
  List<Item> items = <Item>[];

  // Future<List<Item>> fetchAlbum() async {
  //   http.Response response =
  //       await http.get(Uri.parse('http://43.240.11.169:4000/get'));
  //
  //   if (response.statusCode == 200) {
  //     final List result = json.decode(response.body);
  //     items = result.map((dynamic item) => Item.fromJson(item)).toList();
  //     return items;
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItem().whenComplete(() => setState(() {}));
  }

  Future<List<Item>> getItem() async {
    items = await service.fetchAlbum();

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Database"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            nameController = TextEditingController();
            insertdailog(context);
          },
          child: const Icon(Icons.add)),
      body: Builder(builder: (context) {
        if(items.length != null) {
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(5),
                child: ListTile(
                  onTap: () {
                    nameController.text = items[index].name;
                    updatedialog(context, index);
                  },
                  title: Text(items[index].name.toString()),
                  subtitle: Text(items[index].id.toString()),
                ),
              );
            },
          );
        }
        else{
          return CircularProgressIndicator();
        }
      }),
    );
  }

  Future insertdailog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Insert Data'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [

              TextField(
                keyboardType: TextInputType.text,
                controller: nameController,
                decoration: const InputDecoration(hintText: "Enter Name"),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  //First Method
                  // var map = new Map<String, dynamic>();
                  // map['name'] = nameController.text;
                  //
                  // await http.post(
                  //   Uri.parse('http://43.240.11.169:4000/insert'),
                  //   body: map,
                  // );

                  // Second Method
                  setState(() {
                    service.addData(nameController.text);
                  });
                  Navigator.pop(context);
                },
                child: const Text("ADD"))
          ],
        ),
      );

  Future updatedialog(BuildContext context, int index) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Update Data'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.text,
                controller: nameController,
                decoration: const InputDecoration(hintText: "Enter Name"),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {
                    service.updateData(nameController.text, items[index].id);
                  });
                  Navigator.pop(context);
                },
                child: const Text("Update")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  deletedialog(context, index);
                },
                child: const Text("Delete")),
          ],
        ),
      );

  void deletedialog(BuildContext context, int index) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Delete Data"),
          content: const Text("Are Sure Delete This Data?"),
          actions: [
            TextButton(
                onPressed: () {
                  service
                      .deleteData(items[index].id)
                      .whenComplete(() => setState(() {
                        items.removeAt(index);
                        Navigator.pop(context);
                  }));
                },
                child: const Text("Yes")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"))
          ],
        ),
      );
}
