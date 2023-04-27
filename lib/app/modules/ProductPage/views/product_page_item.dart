import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:minimal_pos/app/data/color_const.dart';

final _faker = Faker();

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: SingleChildScrollView(
        // This Widget will Show Data on your Database
        child: DataTable(
          dataRowHeight: 80,

          // THIS IS FOR TABLE HEADER
          columns: [
            DataColumn(
              label: Text("Item Name"),
            ),
            const DataColumn(
              label: Text("Item Category"),
            ),
            const DataColumn(
              label: Text("Item Price"),
            ),
            const DataColumn(
              label: Text(""),
            ),
          ],
          // THIS IS DATA!!!
          rows: List.generate(
            20,
            (index) {
              String name = _faker.food.dish();
              String category = _faker.food.cuisine();
              int price = _faker.currency.random.integer(200, min: 1);
              return DataRow(
                cells: [
                  DataCell(
                    Text(name),
                  ),
                  DataCell(
                    SizedBox(
                      width: 200,
                      child: Text(category),
                    ),
                  ),
                  DataCell(
                    Text("\$$price"),
                  ),
                  DataCell(
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Icon(Icons.edit),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: actionColor),
                          onPressed: () {},
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
            },
          ),
        ),
      ),
    );
  }
}
