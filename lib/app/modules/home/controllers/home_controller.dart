import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:minimal_pos/app/controllers/category_controller.dart';
import 'package:minimal_pos/app/controllers/item_controller.dart';
import 'package:minimal_pos/app/data/model/item_model.dart';

class HomeController extends GetxController with StateMixin<Box<ItemModel>> {
  final categoryC = CategoryController.instance;
  final itemC = ItemController.instance;
}
