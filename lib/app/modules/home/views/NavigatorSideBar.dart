import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:minimal_pos/app/data/color_const.dart';
import 'package:minimal_pos/app/data/model/item_model.dart';
import 'package:minimal_pos/app/data/model/order_model.dart';
import 'package:minimal_pos/app/data/prefWidget.dart';
import 'package:minimal_pos/app/modules/home/controllers/home_controller.dart';

class NavigatorSideBar extends GetView<HomeController> {
  NavigatorSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: Get.height,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // THIS SECTION IS FOR ITEM ON ORDER
            Flexible(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: controller.cartList.length,
                    itemBuilder: (context, index) {
                      ItemModel item =
                          controller.cartList.keys.elementAt(index);
                      int totalItem =
                          controller.cartList.values.elementAt(index);
                      return ListTile(
                        title: Text(
                          item.name,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${item.price} x $totalItem"),
                            Text("${item.price * totalItem}"),
                          ],
                        ),
                      );
                    },
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
                        Text(controller.subtotalCart.toString(),
                            style: Get.textTheme.bodyLarge),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tax 10%', style: Get.textTheme.bodyLarge),
                        Text(controller.getTax.toString(),
                            style: Get.textTheme.bodyLarge),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total'),
                        Text(controller.totalPrice.toString()),
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
              onPressed: () {
                if (controller.cartList.length != 0) {
                  final nameC = TextEditingController();
                  Get.defaultDialog(
                    content: PreferredWidget.customTextfield(
                      textController: nameC,
                      label: "customer name",
                    ),
                    title: "Enter Customer's name",
                    onConfirm: () async {
                      var cart = {};
                      cart.addAll(controller.cartList);
                      if (nameC.text.isNotEmpty) {
                        OrderModel model = OrderModel(
                          name: nameC.text,
                          orders: cart,
                          price: controller.totalPrice,
                          subPrice: controller.subtotalCart.toDouble(),
                          taxPrice: controller.getTax,
                          createdAt: DateTime.now(),
                          id: "${DateTime.now()} + ${nameC.text}",
                        );

                        await controller.orderC
                            .addOrder(model)
                            .then((value) => controller.cartList.clear());
                        var a = await controller.createInvoicePDF(model);
                        print(a.path);
                        Get.back();
                      } else {
                        Get.snackbar('Warning', "must enter name",
                            backgroundColor: actionColor,
                            colorText: secondaryColor);
                      }
                    },
                  );
                }
              },
              child: Text(
                "PLACE ORDER",
                style: TextStyle(color: secondaryColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
