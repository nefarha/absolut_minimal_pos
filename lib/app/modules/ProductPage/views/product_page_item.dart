import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:minimal_pos/app/controllers/item_controller.dart';
import 'package:minimal_pos/app/data/color_const.dart';
import 'package:minimal_pos/app/data/model/item_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _faker = Faker();

class ProductItem extends GetView<ItemController> {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (itemBox) => ValueListenableBuilder(
        valueListenable: itemBox!.listenable(),
        builder: (context, value, child) => (value.length > 0)
            ? SizedBox(
                width: Get.width,
                child: SingleChildScrollView(
                  // This Widget will Show Data on your Database
                  child: DataTable(
                    dataRowHeight: 80,
                    // THIS IS FOR TABLE HEADER
                    columns: const [
                      DataColumn(
                        label: Text("Item Name"),
                      ),
                      DataColumn(
                        label: Text("Item Category"),
                      ),
                      DataColumn(
                        label: Text("Item Price"),
                      ),
                      DataColumn(
                        label: Text(""),
                      ),
                    ],
                    // THIS IS DATA!!!
                    rows: List.generate(itemBox.length, (index) {
                      ItemModel item = itemBox.getAt(index)!;
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(item.name),
                          ),
                          DataCell(
                            SizedBox(
                              width: 200,
                              child: Text(item.category),
                            ),
                          ),
                          DataCell(
                            Text("\$${item.price}"),
                          ),
                          DataCell(
                            Row(
                              children: [
                                // EDIT EXISTING DATA
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Icon(Icons.edit),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                // DELETE EXISTING DATA
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: actionColor),
                                  onPressed: () {
                                    itemBox.deleteAt(index);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
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
