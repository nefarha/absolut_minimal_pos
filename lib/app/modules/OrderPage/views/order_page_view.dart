import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:minimal_pos/app/modules/OrderPage/views/order_page_item.dart';

import '../controllers/order_page_controller.dart';

class OrderPageView extends GetView<OrderPageController> {
  const OrderPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Orders",
          style: Get.textTheme.headlineMedium,
        ),
        OrderPageItem()
      ],
    );
  }
}
