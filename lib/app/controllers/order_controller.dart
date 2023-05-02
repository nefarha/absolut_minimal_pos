import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:minimal_pos/app/data/model/item_model.dart';
import 'package:minimal_pos/app/data/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderController extends GetxController with StateMixin<Box<OrderModel>> {
  static OrderController get instance => Get.find();
  var orderBox = Rxn<Box<OrderModel>>();

  List<OrderModel> get orderList => orderBox.value!.values.toList();

  // THIS WIDGET IS USED FOR EXPANSION TILE ON order_page_item.dart FILE
  List<Widget> createWidgetExpansion(OrderModel model) {
    List<Widget> expandedList = model.orders.entries.map(
      (order) {
        ItemModel itemModel = order.key;
        int countItem = order.value;
        return ListTile(
          leading: Text("-"),
          title: Text(itemModel.name),
          subtitle: Text(
            "\$${itemModel.price} x $countItem",
          ),
          trailing: Text("\$${itemModel.price * countItem}"),
        );
      },
    ).toList();
    expandedList.add(
      ListTile(
        leading: Text("-"),
        title: Text("Subtotal: ${model.subPrice}"),
        subtitle: Text("tax: ${model.taxPrice}"),
        trailing: Text(
          "Total: ${model.price}",
          style: Get.textTheme.headlineSmall,
        ),
      ),
    );
    return expandedList;
  }

  Future addOrder(OrderModel model) async {
    orderBox.value!.add(model);
  }

  void deleteOrder(OrderModel model) {
    var list = orderBox.value!.values.toList();
    var index = list.indexOf(model);
    orderBox.value!.deleteAt(index);
  }

  @override
  void onInit() {
    change(orderBox.value = Hive.box("orderBox"), status: RxStatus.success());
    super.onInit();
  }
}
