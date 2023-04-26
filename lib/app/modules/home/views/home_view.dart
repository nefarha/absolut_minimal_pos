import 'package:faker/faker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:minimal_pos/app/data/color_const.dart';

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
          buildCategoryItem(),
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
          buildContentItem(),
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

  Widget buildCategoryItem() {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          String categoryName = _faker.food.cuisine();
          return Card(
            child: Container(
              height: 100,
              width: 200,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.category),
                  Text(
                    categoryName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildContentItem() {
    return Expanded(
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          String categoryName = _faker.food.cuisine();
          String itemName = _faker.food.dish();
          int itemPrice = _faker.currency.random.integer(200, min: 1);
          return Card(
            child: Container(
              height: 100,
              width: 200,
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoryName,
                    style: Get.textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    itemName,
                    style: Get.textTheme.titleLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "\$$itemPrice",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: actionColor,
                        ),
                        onPressed: () {},
                        child: Icon(
                          Icons.remove,
                          color: secondaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: actionColor,
                        ),
                        onPressed: () {},
                        child: Icon(
                          Icons.add,
                          color: secondaryColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
