// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'order_model.g.dart';

@HiveType(typeId: 1)
class OrderModel {
  @HiveField(0)
  String name;

  @HiveField(1)
  Map<dynamic, dynamic> orders;

  @HiveField(2)
  double price;

  @HiveField(3)
  double subPrice;

  @HiveField(4)
  double taxPrice;

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  String id;

  OrderModel({
    required this.name,
    required this.orders,
    required this.price,
    required this.subPrice,
    required this.taxPrice,
    required this.createdAt,
    required this.id,
  });
}
