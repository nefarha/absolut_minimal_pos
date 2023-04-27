import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:minimal_pos/app/modules/home/views/home_page_category.dart';
import 'package:minimal_pos/app/modules/home/views/home_page_item.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final _faker = Faker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Item',
                style: Get.textTheme.headlineMedium,
              ),
              buildTextFieldHome(),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          HomePageItem(),
        ],
      ),
    );
  }

  Widget buildTextFieldHome() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        width: 400,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
