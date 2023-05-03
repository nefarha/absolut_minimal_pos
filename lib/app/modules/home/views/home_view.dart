import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../views/NavigatorSideBar.dart';
import 'package:minimal_pos/app/modules/home/views/home_page_category.dart';
import 'package:minimal_pos/app/modules/home/views/home_page_item.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Flexible(
              child: SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category',
                      style: Get.textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    HomeCategory(),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Item',
                      style: Get.textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    HomePageItem(),
                  ],
                ),
              ),
            ),
            NavigatorSideBar()
          ],
        ),
      ),
    );
  }
}
