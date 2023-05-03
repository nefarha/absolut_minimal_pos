import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minimal_pos/app/controllers/order_controller.dart';
import 'package:minimal_pos/app/data/color_const.dart';
import 'package:minimal_pos/app/data/model/order_model.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:minimal_pos/app/modules/OrderPage/controllers/order_page_controller.dart';

class OrderPageItem extends GetView<OrderController> {
  OrderPageItem({super.key});

  final orderPageC = Get.find<OrderPageController>();
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      // VALUE LISTENABLE BUILDER FOR NOTIFY CHANGE IN BOX FROM HIVE
      (box) => ValueListenableBuilder(
        valueListenable: box!.listenable(),
        builder: (context, value, child) => Expanded(
          // GROUPED LISTVIEW USED FOR GROUPING ORDER ITEM BY DATE
          child: GroupedListView<OrderModel, DateTime>(
            // THIS IS ELEMENT FOR ITEM, LIKE "CHILDREN" ON WIDGET, YOU MUST PROVIDE LIST OF ITEM
            elements: controller.orderList,
            // THIS IS HOW YOU GROUP YOUR ITEM
            groupBy: (element) {
              return DateTime(
                element.createdAt.year,
                element.createdAt.month,
                element.createdAt.day,
              );
            },
            order: GroupedListOrder.DESC,
            // THIS IS THE BUILDER FOR SEPARATOR, YOU WILL SEE AT TOP OF EACH DAY LIKE ITs DATE
            groupSeparatorBuilder: (date) => SizedBox(),
            // THIS IS THE BUILDER FOR ITEM WIDGET
            itemBuilder: (context, element) {
              OrderModel model = element;
              var isExpanded = false.obs;

              // THIS IS FOR CEHCKING IS DATE IS SAME
              return Obx(
                () {
                  if (DateTime(
                          orderPageC.pickedDateTime.value!.year,
                          orderPageC.pickedDateTime.value!.month,
                          orderPageC.pickedDateTime.value!.day)
                      //This function is for checking is date is same on year, month and day
                      .isAtSameMomentAs(
                    DateTime(model.createdAt.year, model.createdAt.month,
                        model.createdAt.day),
                  )) {
                    return ExpansionTile(
                      onExpansionChanged: (value) => isExpanded.toggle(),
                      leading: (isExpanded.value)
                          ? const Icon(Icons.expand_less)
                          : const Icon(Icons.expand_more),
                      title: Text(
                        model.name,
                        style: Get.textTheme.headlineSmall,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          controller.deleteOrder(model);
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: actionColor,
                        ),
                      ),
                      children: controller.createWidgetExpansion(model),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
