import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minimal_pos/app/controllers/order_controller.dart';
import 'package:minimal_pos/app/data/model/item_model.dart';
import 'package:minimal_pos/app/data/model/order_model.dart';

class OrderPageItem extends GetView<OrderController> {
  const OrderPageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (box) => ValueListenableBuilder(
        valueListenable: box!.listenable(),
        builder: (context, value, child) => Expanded(
          child: ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              OrderModel model = box.getAt(index)!;
              return ExpansionTile(
                title: Text(model.name),
                children: model.orders.entries.map((order) {
                  ItemModel itemModel = order.key;

                  return Row(
                    children: [
                      Text(itemModel.name),
                      Text(itemModel.price.toString()),
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
