import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class CategoryController extends GetxController with StateMixin<Box> {
  static CategoryController get instance => Get.find();
  var categoryBox = Rxn<Box>();

  void addCategory() {
    final catTextC = TextEditingController();
    Get.defaultDialog(
      content: Card(
        child: Container(
          padding: EdgeInsets.all(8),
          width: 400,
          child: TextField(
            controller: catTextC,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      onConfirm: () {
        if (catTextC.text.isNotEmpty && catTextC.text != "") {
          print("sukses");
          categoryBox.value!.add(catTextC.text);
          Get.back();
        }
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
