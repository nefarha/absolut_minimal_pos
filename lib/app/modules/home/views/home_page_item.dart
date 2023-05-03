import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_pos/app/controllers/item_controller.dart';
import 'package:minimal_pos/app/data/color_const.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:minimal_pos/app/modules/home/controllers/home_controller.dart';

class HomePageItem extends GetView<ItemController> {
  HomePageItem({super.key});

  final homeC = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (itemBox) => ValueListenableBuilder(
        valueListenable: itemBox!.listenable(),
        builder: (context, value, child) => (value.length > 0)
            ? Expanded(
                child: Obx(
                  () => GridView(
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                    ),
                    children:
                        // THIS SECTION IS TO VIEW ITEM
                        (() {
                      List<Widget> widgetList = [];
                      if (homeC.selectedCategory.value.isNotEmpty) {
                        itemBox.values.map(
                          (item) {
                            if (item.category == homeC.selectedCategory.value)
                              widgetList.add(homeC.createItemView(item));
                          },
                        ).toList();
                      } else {
                        itemBox.values
                            .map(
                              (item) => widgetList.add(
                                homeC.createItemView(item),
                              ),
                            )
                            .toList();
                      }
                      return widgetList;
                    }()),
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
      onLoading: Center(
        child: Column(
          children: const [
            CircularProgressIndicator(
              color: actionColor,
              strokeWidth: 10,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
                'Reading data from local database, please wait, if this happen, you have potato device or something went wrong/')
          ],
        ),
      ),
    );
  }
}
