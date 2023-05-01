import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_pos/app/modules/OrderPage/views/order_page_view.dart';
import 'package:minimal_pos/app/modules/ProductPage/views/product_page_view.dart';
import 'package:minimal_pos/app/modules/home/views/home_view.dart';

class PageNavigatorController extends GetxController {
  List<Widget> pageMenu = [
    HomeView(),
    ProductPageView(),
    OrderPageView(),
  ];

  final railIndex = 0.obs;
  set setRailIndex(int newVal) => railIndex.value = newVal;
}
