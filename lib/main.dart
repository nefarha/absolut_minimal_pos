import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:minimal_pos/app/controllers/category_controller.dart';
import 'package:minimal_pos/app/controllers/item_controller.dart';
import 'package:minimal_pos/app/controllers/order_controller.dart';
import 'package:minimal_pos/app/data/color_const.dart';
import 'package:minimal_pos/app/data/model/item_model.dart';
import 'package:minimal_pos/app/data/model/order_model.dart';
import 'package:minimal_pos/app/modules/OrderPage/controllers/order_page_controller.dart';
import 'package:minimal_pos/app/modules/ProductPage/controllers/product_page_controller.dart';
import 'package:minimal_pos/app/modules/home/controllers/home_controller.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory path = await path_provider.getApplicationDocumentsDirectory();
  Hive.registerAdapter(ItemModelAdapter());
  Hive.registerAdapter(OrderModelAdapter());
  Hive.init(path.path);

  // open box for database
  await Hive.openBox<ItemModel>("itemBox");
  await Hive.openBox("categoryBox");
  await Hive.openBox<OrderModel>("orderBox");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final categoryController = Get.put(CategoryController());
  final itemController = Get.put(ItemController());
  final orderController = Get.put(OrderController());
  final orderPageController = Get.put(OrderPageController());
  final homeContoller = Get.put(HomeController());
  final productContoller = Get.put(ProductPageController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: customThemeData(),
      title: "Application",
      initialRoute: Routes.PAGE_NAVIGATOR,
      getPages: AppPages.routes,
    );
  }
}

ThemeData customThemeData() {
  return ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.interTextTheme(),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: secondaryColor,
      secondary: actionColor,
      onSecondary: secondaryColor,
      error: actionColor,
      onError: secondaryColor,
      background: secondaryColor,
      onBackground: primaryColor,
      surface: secondaryColor,
      onSurface: primaryColor,
    ),
  );
}
