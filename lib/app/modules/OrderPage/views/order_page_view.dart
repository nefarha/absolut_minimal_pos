import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:minimal_pos/app/data/color_const.dart';
import 'package:minimal_pos/app/modules/OrderPage/views/order_page_item.dart';

import '../controllers/order_page_controller.dart';

class OrderPageView extends GetView<OrderPageController> {
  OrderPageView({Key? key}) : super(key: key);
  final currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Current Date: ${currentDate.year}-${currentDate.month}-${currentDate.day}",
            style: Get.textTheme.displaySmall,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Orders",
                style: Get.textTheme.headlineMedium,
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(3000))
                      .then((value) => (value != null)
                          ? controller.pickedDateTime.value = value
                          : DateTime.now());
                },
                child: Obx(
                  () => Text(
                      'find order on date : ${controller.pickedDateTime.value!.year}-${controller.pickedDateTime.value!.month}-${controller.pickedDateTime.value!.day}'),
                ),
              ),
              Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: actionColor),
                onPressed: () {
                  controller.createPdfReport();
                },
                child: Text(
                  "EXPORT PDF SALES",
                  style: TextStyle(color: secondaryColor),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          OrderPageItem(),
        ],
      ),
    );
  }
}
