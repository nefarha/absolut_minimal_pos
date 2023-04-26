import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_page_controller.dart';

class ProductPageView extends GetView<ProductPageController> {
  const ProductPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductPageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProductPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
