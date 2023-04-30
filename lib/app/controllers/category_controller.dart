import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:minimal_pos/app/data/color_const.dart';
import 'package:minimal_pos/app/data/prefWidget.dart';

class CategoryController extends GetxController with StateMixin<Box> {
  static CategoryController get instance => Get.find();
  var categoryBox = Rxn<Box>();

  void addCategory() {
    final catTextC = TextEditingController();
    Get.defaultDialog(
      title: "Add Category",
      content: PreferredWidget.customTextfield(
          textController: catTextC, label: "Category Name"),
      onConfirm: () {
        if (catTextC.text.isNotEmpty && catTextC.text != "") {
          print("sukses");
          categoryBox.value!.add(catTextC.text);
          Get.back();
        }
      },
    );
  }

  void deleteCategory({required String catName, required int index}) {
    Get.defaultDialog(
      title: "Delete Category",
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                catName,
                style: Get.textTheme.headlineMedium,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              categoryBox.value!.deleteAt(index);
              Get.back();
            },
            icon: Icon(
              Icons.delete,
              color: actionColor,
            ),
          )
        ],
      ),
      onConfirm: () {
        Get.back();
      },
    );
  }

  @override
  void onReady() {
    categoryBox.value = Hive.box("categoryBox");
    change(
      categoryBox.value,
      status: RxStatus.success(),
    );
    super.onReady();
  }
}
