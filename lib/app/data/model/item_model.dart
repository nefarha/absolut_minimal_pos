// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:hive/hive.dart';
part 'item_model.g.dart';

final faker = Faker();

@HiveType(typeId: 0)
class ItemModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  int price;
  @HiveField(2)
  String category;
  ItemModel({
    required this.name,
    required this.price,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'category': category,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      name: map['name'] as String,
      price: map['price'] as int,
      category: map['category'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<ItemModel> fakeItem = List.generate(10, (index) {
    String name = faker.food.dish();
    int price = faker.currency.random.integer(200, min: 1);
    String category = faker.food.cuisine();
    return ItemModel(
      name: name,
      price: price,
      category: category,
    );
  });
}
