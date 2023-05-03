import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minimal_pos/app/controllers/category_controller.dart';
import 'package:minimal_pos/app/data/color_const.dart';
import 'package:minimal_pos/app/modules/home/controllers/home_controller.dart';

class HomeCategory extends GetView<CategoryController> {
  HomeCategory({super.key});

  final homeC = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (box) => ValueListenableBuilder(
        valueListenable: box!.listenable(),
        builder: (context, value, child) => (value.length > 0)
            ? GestureDetector(
                child: SizedBox(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      String categoryName = box.getAt(index);
                      return GestureDetector(
                        onTap: () {
                          if (homeC.selectedCategory.value == categoryName) {
                            homeC.selectedCategory.value = "";
                          } else
                            homeC.selectedCategory.value = categoryName;
                        },
                        child: Obx(
                          () => Card(
                            color:
                                (homeC.selectedCategory.value == categoryName)
                                    ? actionColor
                                    : null,
                            child: Container(
                              height: 100,
                              width: 200,
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}
