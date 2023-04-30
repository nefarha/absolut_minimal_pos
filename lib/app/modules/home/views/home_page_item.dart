import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_pos/app/controllers/item_controller.dart';
import 'package:minimal_pos/app/data/color_const.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePageItem extends GetView<ItemController> {
  const HomePageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (itemBox) => (itemBox!.length > 0)
          ? ValueListenableBuilder(
              valueListenable: itemBox.listenable(),
              builder: (context, value, child) => Expanded(
                child: GridView(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                  ),
                  children: itemBox.values
                      .map(
                        (item) => Card(
                          child: Container(
                            height: 100,
                            width: 200,
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.category,
                                  style: Get.textTheme.bodySmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  item.name,
                                  style: Get.textTheme.titleLarge,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "\$${item.price}",
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
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          : Center(
              child: Text(
                "No Item or Data in Database",
                style: Get.textTheme.headlineLarge,
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
