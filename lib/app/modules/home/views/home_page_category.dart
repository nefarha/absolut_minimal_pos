import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minimal_pos/app/controllers/category_controller.dart';

class HomeCategory extends GetView<CategoryController> {
  const HomeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (box) => ValueListenableBuilder(
        valueListenable: box!.listenable(),
        builder: (context, value, child) => (value.length > 0)
            ? SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    String categoryName = box.getAt(index);
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
              )
            : Center(
                child: Text(
                  "No Item or Data in Database",
                  style: Get.textTheme.headlineLarge,
                ),
              ),
      ),
    );
  }
}
