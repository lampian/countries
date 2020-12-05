import 'package:countries_info/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/countries_controller.dart';
import 'controllers/country_detail_controller.dart';

void main() {
  runApp(PalotaCountriesAssessmentApp());
}

class PalotaCountriesAssessmentApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put<CountriesController>(CountriesController());
    Get.put<CountryDetailController>(CountryDetailController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRoutes.startUp,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
