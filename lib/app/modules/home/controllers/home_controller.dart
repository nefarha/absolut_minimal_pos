import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:minimal_pos/app/controllers/category_controller.dart';
import 'package:minimal_pos/app/controllers/item_controller.dart';
import 'package:minimal_pos/app/controllers/order_controller.dart';
import 'package:minimal_pos/app/data/model/item_model.dart';

class HomeController extends GetxController with StateMixin<Box<ItemModel>> {
  final categoryC = CategoryController.instance;
  final itemC = ItemController.instance;
  final orderC = OrderController.instance;

  var cartList = {}.obs;

  int get subtotalCart {
    if (cartList.length > 0) {
      return cartList.entries
          .map((item) => item.key.price * item.value)
          .toList()
          .reduce((value, element) => value + element);
    }
    return 0;
  }

  get getTax => (subtotalCart * 0.1);

  get totalPrice => (subtotalCart + getTax);

  void addCart(ItemModel item) {
    if (!cartList.containsKey(item)) {
      cartList[item] = 1;
    } else {
      cartList[item] += 1;
    }
  }

  void removeFromCart(ItemModel item) {
    try {
      if (cartList.containsKey(item) && cartList[item] == 1) {
        cartList.removeWhere((key, value) => key == item);
      } else {
        cartList[item] -= 1;
      }
    } catch (e) {}
  }
}
