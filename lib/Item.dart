import 'dart:core';

class Item {
  late final String id;
  late final String name;
  late final String superiorId;


  Item({required this.id, required this.name, required this.superiorId});

  factory Item.fromJson(Map<String,dynamic> data){
    return Item(
        id : data['_id'],
        name : data['name'],
        superiorId : data['superiorId']);
  }

  String getId() {
    return id;
  }

  void setId(String id) {
    this.id = id;
  }

  String getName() {
    return name;
  }

  void setName(String name) {
    this.name = name;
  }

  String getSuperiorId() {
    return superiorId;
  }

  void setSuperiorId(String superiorId) {
    this.superiorId = superiorId;
  }

  @override
  String toString() {
    return 'Item{id: $id, name: $name, superiorId: $superiorId}';
  }
}
