import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:minimal_pos/app/data/color_const.dart';

import '../controllers/page_navigator_controller.dart';

class PageNavigatorView extends GetView<PageNavigatorController> {
  const PageNavigatorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local POS'),
        elevation: 0,
        surfaceTintColor: secondaryColor,
      ),
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => Row(
          children: [
            buildRailNavigator(),
            Flexible(
              child: controller.pageMenu[controller.railIndex.value],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRailNavigator() {
    return Obx(
      () => NavigationRail(
        labelType: NavigationRailLabelType.all,
        onDestinationSelected: (value) => controller.setRailIndex = value,
        selectedIndex: controller.railIndex.value,
        destinations: const [
          NavigationRailDestination(
            icon: Icon(Icons.home),
            label: Text("Home"),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.menu_book),
            label: Text("Product"),
          ),
        ],
      ),
    );
  }
}
