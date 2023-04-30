import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:minimal_pos/app/data/color_const.dart';
import 'package:minimal_pos/app/data/model/item_model.dart';
import 'package:minimal_pos/app/modules/ProductPage/views/product_page_category.dart';
import 'package:minimal_pos/app/modules/ProductPage/views/product_page_item.dart';

import '../controllers/product_page_controller.dart';

class ProductPageView extends GetView<ProductPageController> {
  const ProductPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildNewItem(
            Title: "Add Category",
            onTap: () {
              controller.categoryC.addCategory();
            },
          ),
          SizedBox(
            height: 10,
          ),
          ProductCategory(),
          SizedBox(
            height: 10,
          ),
          buildNewItem(
            Title: "Add Item",
            onTap: () {},
          ),
          SizedBox(
            height: 10,
          ),
          Flexible(child: ProductItem()),
        ],
      ),
    );
  }

  Widget buildNewItem({required String Title, Function()? onTap}) {
    return Row(
      children: [
        Text(
          Title,
          style: Get.textTheme.headlineMedium,
        ),
        SizedBox(
          width: 20,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: actionColor),
          onPressed: onTap,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget buildAddItem() {
    return Text("data");
  }
}
