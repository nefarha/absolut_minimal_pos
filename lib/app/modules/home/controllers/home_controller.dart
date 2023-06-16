import 'dart:io';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:minimal_pos/app/controllers/category_controller.dart';
import 'package:minimal_pos/app/controllers/item_controller.dart';
import 'package:minimal_pos/app/controllers/order_controller.dart';
import 'package:minimal_pos/app/data/color_const.dart';
import 'package:minimal_pos/app/data/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:minimal_pos/app/data/model/order_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeController extends GetxController with StateMixin<Box<ItemModel>> {
  final categoryC = CategoryController.instance;
  final itemC = ItemController.instance;
  final orderC = OrderController.instance;

  // BELOW IS FOR CREATING VIEW OF ITEM
  var selectedCategory = "".obs;
  Widget createItemView(ItemModel item) {
    return Card(
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
                    removeFromCart(item);
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
                    addCart(item);
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
    );
  }

  // THIS IS TO CREATE PDF INVOICE for order
  Future<File> createInvoicePDF(OrderModel model) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a6,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(model.name.toUpperCase()),
              pw.SizedBox(height: 30),
              // THIS IS TABLE FOR SHOWING ORDER ITEMS
              pw.Table(
                // THIS IS FOR TABLE BORDER

                border: pw.TableBorder(
                  horizontalInside: pw.BorderSide(
                    color: PdfColor.fromHex("#000000"),
                  ),
                  bottom: pw.BorderSide(
                    color: PdfColor.fromHex("#000000"),
                  ),
                  verticalInside: pw.BorderSide(
                    color: PdfColor.fromHex("#000000"),
                  ),
                  left: pw.BorderSide(
                    color: PdfColor.fromHex("#000000"),
                  ),
                  right: pw.BorderSide(
                    color: PdfColor.fromHex("#000000"),
                  ),
                  top: pw.BorderSide(
                    color: PdfColor.fromHex("#000000"),
                  ),
                ),

                children: model.orders.entries.map(
                  (item) {
                    ItemModel itemModel = item.key;
                    int countItem = item.value;
                    return pw.TableRow(
                      children: [
                        pw.Padding(
                            padding: pw.EdgeInsets.all(8),
                            child: pw.Text(itemModel.name)),
                        pw.Padding(
                            padding: pw.EdgeInsets.all(8),
                            child: pw.Text("${itemModel.price} x $countItem")),
                        pw.Padding(
                            padding: pw.EdgeInsets.all(8),
                            child: pw.Text("${itemModel.price * countItem}")),
                      ],
                    );
                  },
                ).toList(),
              ),
              pw.SizedBox(height: 5),
              pw.Table(
                children: [
                  pw.TableRow(
                    children: [
                      pw.Text("Subprice"),
                      pw.Text(model.subPrice.toString()),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text("Tax 10%"),
                      pw.Text(model.taxPrice.toString()),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Text("Total"),
                      pw.Text(model.price.toString()),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 5),
            ],
          );
        },
      ),
    );

    final output = await getExternalStorageDirectory();
    final file = File("${output!.path}/invoice_${DateTime.now()}.pdf");
    if (await file.exists()) {
      file.delete();
    }
    final bytes = await pdf.save();
    await file.writeAsBytes(bytes);
    return file;
  }

  /// THIS IS ORDER CART SECTION

  var cartList = {}.obs;

  int get subtotalCart {
    if (cartList.length > 0) {
      return cartList.entries
          .map((item) => item.key.price * item.value)
          .toList()
          .reduce((value, element) => value + element);
    }
    return 0;
  }

  get getTax => (subtotalCart * 0.1);

  get totalPrice => (subtotalCart + getTax);

  void addCart(ItemModel item) {
    if (!cartList.containsKey(item)) {
      cartList[item] = 1;
    } else {
      cartList[item] += 1;
    }
  }

  void removeFromCart(ItemModel item) {
    try {
      if (cartList.containsKey(item) && cartList[item] == 1) {
        cartList.removeWhere((key, value) => key == item);
      } else {
        cartList[item] -= 1;
      }
    } catch (e) {}
  }
}
