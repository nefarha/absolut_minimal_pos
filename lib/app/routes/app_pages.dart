import 'package:get/get.dart';

import '../modules/PageNavigator/bindings/page_navigator_binding.dart';
import '../modules/PageNavigator/views/page_navigator_view.dart';
import '../modules/ProductPage/bindings/product_page_binding.dart';
import '../modules/ProductPage/views/product_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PAGE_NAVIGATOR,
      page: () => PageNavigatorView(),
      binding: PageNavigatorBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_PAGE,
      page: () => const ProductPageView(),
      binding: ProductPageBinding(),
    ),
  ];
}
