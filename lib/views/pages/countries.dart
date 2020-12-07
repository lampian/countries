import 'package:countries_info/controllers/countries_controller.dart';
import 'package:countries_info/model/country_model.dart';
import 'package:countries_info/services/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'about.dart';
import 'countryDetail.dart';

class CountriesPage extends GetWidget<CountriesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("African Countries"),
        actions: [
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () => Get.to(AboutPage())),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: getBody(),
        ),
      ),
    );
  }

  //widget responsible for listing the countries
  Widget getBody() {
    return Container(
      child: GetX(
        builder: (_) {
          if (controller.countries.length == 0 && controller.searchText == '') {
            return showLoading();
          } else if (controller.countries.length == 0 &&
              controller.searchText != '') {
            return showNoneFound();
          } else {
            return showList();
          }
        },
      ),
    );
  }

  Expanded showLoading() {
    return Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ]),
    );
  }

  Expanded showNoneFound() {
    return Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('No countries found that include '
                '${controller.searchText}'),
          ]),
    );
  }

  Widget showList() {
    return Column(
      children: [
        searchBar(),
        SizedBox(height: 12),
        listGroup(),
      ],
    );
  }

  Widget listGroup() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (_, __) => Divider(
          height: 5.0,
          thickness: 3.0,
          indent: 125.0,
        ),
        itemCount: controller.countries.length,
        itemBuilder: (item, index) {
          return countryTile(controller.countries[index]);
        },
      ),
    );
  }

  // tiles displaying flag, name and capital of country
  Widget countryTile(CountryModel aCountry) {
    return GestureDetector(
      onTap: () {
        Get.to(CountryDetailPage(aCountry.name));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          flagGroup(aCountry),
          titleGroup(aCountry),
          iconGroup(),
        ],
      ),
    );
  }

  Widget iconGroup() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          children: [
            const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget titleGroup(CountryModel aCountry) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(aCountry.name),
            Text(aCountry.capital),
          ],
        ),
      ),
    );
  }

  Widget flagGroup(CountryModel aCountry) {
    return SizedBox(
      width: 80.0,
      height: 60.0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0.0,
            width: 60.0,
            child: aCountry.flagUrl != null
                ? svgPicture(aCountry.flagUrl, 40.0, aCountry.code)
                : Image.asset(blankFlagName),
          ),
          Positioned(
            left: 40.0,
            top: 30.0,
            width: 40.0,
            child: Container(
              child: Center(
                child: Text(
                  aCountry.code,
                  style: TextStyle(
                      color: Colors.grey[100],
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey[500],
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBar() {
    return Container(
        width: 360,
        height: 54,
        padding: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
              spreadRadius: 1,
              blurRadius: 1,
            ),
          ],
        ),
        child: TextField(
          controller: controller.searchTextCntl,
          onChanged: (_) => controller.handleTextInput(_),
          decoration: InputDecoration(
            hintText: 'Search countries',
            hintStyle: TextStyle(color: Colors.grey[700]),
            filled: false,
            fillColor: Colors.white,
            suffixIcon: IconButton(
              icon: Icon(Icons.clear_sharp),
              onPressed: () {
                controller.searchTextCntl.clear();
              },
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
                borderSide: BorderSide(color: Colors.grey[100])),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              borderSide: BorderSide(color: Colors.grey[100], width: 1),
            ),
          ),
        ));
  }
}
