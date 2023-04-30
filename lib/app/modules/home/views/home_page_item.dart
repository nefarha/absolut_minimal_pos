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
                                // SHOW ITEM CATEGORY ON TOP
                                Text(
                                  item.category,
                                  style: Get.textTheme.bodySmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                // THIS IS ITEM NAME
                                Text(
                                  item.name,
                                  style: Get.textTheme.titleLarge,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // THIS IS ITEM PRICE
                                Text(
                                  "\$${item.price}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Spacer(),
                                // THIS IS ACTION BUTTON ON ITEM CARD
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // THIS IS FOR SUBSTRACT OR REMOVE ITEM FROM CART
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: actionColor,
                                      ),
                                      onPressed: () {
                                        homeC.removeFromCart(item);
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        color: secondaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    // THIS IS FOR ADDING ITEM TO CART
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: actionColor,
                                      ),
                                      onPressed: () {
                                        homeC.addCart(item);
                                      },
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
