import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:minimal_pos/app/controllers/category_controller.dart';
import 'package:minimal_pos/app/data/model/item_model.dart';
import 'package:minimal_pos/app/data/prefWidget.dart';

class ItemController extends GetxController with StateMixin<Box<ItemModel>> {
  static ItemController get instance => Get.find();
  var categoryC = CategoryController.instance;
  var itemBox = Rxn<Box<ItemModel>>();

  void addItem() {
    try {
      var selected = RxString(categoryC.categoryBox.value!.getAt(0));
      final nameC = TextEditingController();
      final priceC = TextEditingController();
      Get.defaultDialog(
        title: "Add Item",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PreferredWidget.customTextfield(
                textController: nameC, label: "item name"),
            PreferredWidget.customTextfield(
                textController: priceC, label: "price", isNumber: true),
            Row(
              children: [
                Text("Category :"),
                SizedBox(
                  width: 10,
                ),
                Obx(
                  () => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                        underline: SizedBox(),
                        value: selected.value,
                        items: List.generate(
                          categoryC.categoryBox.value!.length,
                          (index) {
                            String cats =
                                categoryC.categoryBox.value!.getAt(index);
                            return DropdownMenuItem(
                              value: cats,
                              child: Text(cats),
                            );
                          },
                        ),
                        onChanged: (value) => selected.value = value!,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        onConfirm: () {
          if (nameC.text.isNotEmpty && priceC.text.isNotEmpty) {
            ItemModel item = ItemModel(
                name: nameC.text,
                price: int.parse(priceC.text),
                category: selected.value);
            itemBox.value!.add(item);
            Get.back();
          }
        },
      );
    } catch (e) {
      Get.defaultDialog(
        title: "ALERT",
        middleText: "YOU SHOULD ADD CATEGORY FIRST",
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  @override
  void onReady() {
    itemBox.value = Hive.box("itemBox");
    change(
      itemBox.value,
      status: RxStatus.success(),
    );
    super.onReady();
  }
}
