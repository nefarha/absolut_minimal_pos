import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:minimal_pos/app/controllers/category_controller.dart';
import 'package:minimal_pos/app/controllers/item_controller.dart';
import 'package:minimal_pos/app/controllers/order_controller.dart';
import 'package:minimal_pos/app/data/color_const.dart';
import 'package:minimal_pos/app/data/model/item_model.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController with StateMixin<Box<ItemModel>> {
  final categoryC = CategoryController.instance;
  final itemC = ItemController.instance;
  final orderC = OrderController.instance;

  var selectedCategory = "".obs;
  // BELOW IS FOR CREATING VIEW OF ITEM
  Widget createItemView(ItemModel item) {
    return Card(
      child: Container(
        height: 100,
        width: 200,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SHOW ITEM CATEGORY ON TOP
            Text(
              item.category,
              style: Get.textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 40,
            ),
            // THIS IS ITEM NAME
            Text(
              item.name,
              style: Get.textTheme.titleLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // THIS IS ITEM PRICE
            Text(
              "\$${item.price}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            // THIS IS ACTION BUTTON ON ITEM CARD
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // THIS IS FOR SUBSTRACT OR REMOVE ITEM FROM CART
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: actionColor,
                  ),
                  onPressed: () {
                    removeFromCart(item);
                  },
                  child: Icon(
                    Icons.remove,
                    color: secondaryColor,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                // THIS IS FOR ADDING ITEM TO CART
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: actionColor,
                  ),
                  onPressed: () {
                    addCart(item);
                  },
                  child: Icon(
                    Icons.add,
                    color: secondaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// BELOW THIS IS ORDER CART SECTION

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
