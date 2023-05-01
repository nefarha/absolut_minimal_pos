import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:minimal_pos/app/data/model/order_model.dart';

class OrderController extends GetxController with StateMixin<Box<OrderModel>> {
  static OrderController get instance => Get.find();
  var orderBox = Rxn<Box<OrderModel>>();

  get orderList => orderBox.value!.values;

  void addOrder(OrderModel model) {
    orderBox.value!.add(model);
  }

  @override
  void onInit() {
    change(orderBox.value = Hive.box("orderBox"), status: RxStatus.success());
    super.onInit();
  }
}
