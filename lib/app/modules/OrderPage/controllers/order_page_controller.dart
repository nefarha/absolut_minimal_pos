import 'package:get/get.dart';
import 'package:minimal_pos/app/data/model/order_model.dart';
import 'package:hive/hive.dart';

class OrderPageController extends GetxController
    with StateMixin<Box<OrderModel>> {
  var orderBox = Rxn<Box<OrderModel>>();

  get orderList => orderBox.value!.values;

  @override
  void onInit() {
    change(orderBox.value = Hive.box("orderBox"), status: RxStatus.success());
    super.onInit();
  }
}
