import 'package:countries_info/controllers/countries_controller.dart';
import 'package:countries_info/model/country_model.dart';
import 'package:countries_info/routes.dart';
import 'package:countries_info/services/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.about)),
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

  Widget getBody() {
    return Stack(
      children: [
        listGroup(),
        searchGroup(),
      ],
    );
  }

  Positioned searchGroup() {
    return Positioned(
      left: 10,
      top: 10,
      child: searchBar(),
    );
  }

  Widget listGroup() {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        GetX(
          builder: (_) {
            if (controller.countries.length == 0 &&
                controller.searchText == '') {
              return Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ]),
              );
            } else if (controller.countries.length == 0 &&
                controller.searchText != '') {
              return Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('No countries found that include '
                          '${controller.searchText}'),
                    ]),
              );
            } else {
              return Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, __) => Divider(
                    height: 5.0,
                    thickness: 3.0,
                    indent: 125,
                  ),
                  itemCount: controller.countries.length,
                  itemBuilder: (item, index) {
                    return countryTile(controller.countries[index]);
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }

  Widget searchBar() {
    return Container(
        width: 360,
        height: 54,
        padding: EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
              spreadRadius: 1,
              blurRadius: 1,
              //offset: Offset(1, 1),
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
            fillColor: Colors.white, //grey[100],
            suffixIcon: controller.searchText == ''
                ? null
                : IconButton(
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

//TODO change listTile to basic widgets
  ListTile countryTile(CountryModel aCountry) {
    return ListTile(
      leading: flagGroup(aCountry),
      title: titleGroup(aCountry),
      subtitle: Align(
        child: Text(aCountry.capital),
        alignment: Alignment(-0.8, 0),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        size: 12,
      ),
      onTap: () {
        Get.to(CountryDetailPage(aCountry.name));
      },
    );
  }

  Widget titleGroup(CountryModel aCountry) {
    return Align(
      child: Text(aCountry.name),
      alignment: Alignment(-0.8, 0),
    );
  }

  Widget flagGroup(CountryModel aCountry) {
    return SizedBox(
      width: 80.0,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0.0,
            width: 60,
            child: aCountry.flagUrl != null
                ? svgPicture(aCountry.flagUrl, 40.0, aCountry.code)
                : Image.asset('assets/images/blankflag.png'),
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
}
