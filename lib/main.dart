import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minimal_pos/app/data/color_const.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: customThemeData(),
      title: "Application",
      initialRoute: Routes.PAGE_NAVIGATOR,
      getPages: AppPages.routes,
    );
  }
}

ThemeData customThemeData() {
  return ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.interTextTheme(),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primaryColor,
      onPrimary: secondaryColor,
      secondary: actionColor,
      onSecondary: secondaryColor,
      error: actionColor,
      onError: secondaryColor,
      background: secondaryColor,
      onBackground: primaryColor,
      surface: secondaryColor,
      onSurface: primaryColor,
    ),
  );
}
