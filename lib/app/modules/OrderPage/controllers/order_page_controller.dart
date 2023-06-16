import 'dart:io';

import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:get/get.dart';
import 'package:minimal_pos/app/data/model/item_model.dart';
import 'package:minimal_pos/app/data/model/order_model.dart';
import 'package:hive/hive.dart';
import 'package:minimal_pos/app/controllers/order_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class OrderPageController extends GetxController
    with StateMixin<Box<OrderModel>> {
  var pickedDateTime = Rx<DateTime?>(DateTime.now());
  final orderC = OrderController.instance;

  Future createPdfReport() async {
    var orderList = orderC.orderList;
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          var widgetList = <pw.SpanningWidget>[
            pw.Text(
                "Sales Report on ${pickedDateTime.value!.year}-${pickedDateTime.value!.month}-${pickedDateTime.value!.day}",
                style: pw.TextStyle(fontSize: 30)),
            pw.SizedBox(height: 20)
          ];

          orderList.forEach((element) {
            DateTime modelDate = DateTime(
              element.createdAt.year,
              element.createdAt.month,
              element.createdAt.day,
            );
            DateTime pickedtime = DateTime(
              pickedDateTime.value!.year,
              pickedDateTime.value!.month,
              pickedDateTime.value!.day,
            );
            if (modelDate.isAtSameMomentAs(pickedtime)) {
              widgetList.add(createInvoice(element));
            }
          });
          return widgetList;
        },
      ),
    );

    final output = await DownloadsPath.downloadsDirectory();
    final file = File(
        "${output!.path}/Sales_Report_${pickedDateTime.value!.year}-${pickedDateTime.value!.month}-${pickedDateTime.value!.day}.pdf");

    if (await file.exists()) {
      file.delete();
    }
    final bytes = await pdf.save();
    await file.writeAsBytes(bytes);
    return file;
  }

  pw.SpanningWidget createInvoice(OrderModel model) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(model.name.toUpperCase()),
        pw.SizedBox(height: 10),
        // THIS IS TABLE
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
        pw.Divider(borderStyle: pw.BorderStyle(phase: 2, pattern: [2])),
        pw.SizedBox(height: 5),
      ],
    );
  }
}
