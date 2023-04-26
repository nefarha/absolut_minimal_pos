import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:minimal_pos/app/data/color_const.dart';
import 'package:minimal_pos/app/modules/PageNavigator/controllers/page_navigator_controller.dart';

class NavigatorSideBar extends GetView<PageNavigatorController> {
  NavigatorSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: Get.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // THIS SECTION IS FOR ITEM ON ORDER
            Flexible(
              child: Card(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: 3,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      "Nama Makanan",
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rp.80000 x 2"),
                        Text("Rp.160000"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // THIS SECTION IS FOR TOTAL
            Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal', style: Get.textTheme.bodyLarge),
                        Text('Rp.1000', style: Get.textTheme.bodyLarge),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tax', style: Get.textTheme.bodyLarge),
                        Text('Rp.100', style: Get.textTheme.bodyLarge),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total'),
                        Text('Rp.1100'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // PLACE ORDER BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(Get.width, 50),
                backgroundColor: actionColor,
              ),
              onPressed: () {},
              child: Text(
                "PLACE ORDER",
                style: TextStyle(color: secondaryColor),
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
