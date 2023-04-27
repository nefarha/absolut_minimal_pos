import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:minimal_pos/app/data/model/item_model.dart';

class HomeController extends GetxController with StateMixin<Box<ItemModel>> {
  var itemBox = Rxn<Box<ItemModel>>();

  @override
  void onReady() {
    itemBox.value = Hive.box("itemBox");
    change(
      itemBox.value,
      status: RxStatus.success(),
    );
    super.onReady();
  }
}
