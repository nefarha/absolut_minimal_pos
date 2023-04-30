import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_pos/app/controllers/category_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductCategory extends GetView<CategoryController> {
  const ProductCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (box) => (box!.length > 0)
          ? ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, value, child) => SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: box.length,
                  itemBuilder: (context, index) {
                    String categoryName = box.getAt(index);
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            categoryName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          : Center(
              child: Text(
                "No Item or Data in Database",
                style: Get.textTheme.headlineLarge,
              ),
            ),
    );
  }
}
