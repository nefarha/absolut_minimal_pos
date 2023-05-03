import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_pos/app/data/model/order_model.dart';
import 'package:hive/hive.dart';

class OrderPageController extends GetxController
    with StateMixin<Box<OrderModel>> {
  var pickedDateTime = Rx<DateTime?>(DateTime.now());

  List<PopupMenuItem> createPopUpButton() {
    return [
      PopupMenuItem(
        child: Text("TODAY"),
        value: DateTime.now(),
      ),
      PopupMenuItem(child: Text("THIS WEEK")),
      PopupMenuItem(child: Text("THIS MONTH")),
    ];
  }
}
