import 'package:countries_info/controllers/countries_controller.dart';
import 'package:countries_info/controllers/country_detail_controller.dart';
import 'package:countries_info/services/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes.dart';

class CountryDetailPage extends GetWidget<CountryDetailController> {
  CountryDetailPage(this.name);
  final name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetX(builder: (contrller) {
          return Text(controller.country.name);
        }),
        actions: [
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.about)),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(0),
        child: Center(
          child: getBody(),
        ),
      ),
    );
  }

  Widget getBody() {
    var contl = Get.find<CountriesController>();
    controller.country = contl.getCountryDetail(name);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 12),
          nameRow(),
          SizedBox(height: 10),
          GetBuilder<CountryDetailController>(builder: (_) {
            return flagRow();
          }),
          descriptionRow(),
          SizedBox(height: 12),
          GetBuilder<CountryDetailController>(builder: (_) {
            return infoRow(
              Icons.location_on_outlined,
              'Sub-region',
              controller.country.subRegion,
            );
          }),
          GetBuilder<CountryDetailController>(builder: (_) {
            return infoRow(
              Icons.location_city_sharp,
              'Captial',
              controller.country.capital,
            );
          }),
          labelRow(Icons.language_sharp, 'Languages'),
          SizedBox(height: 6),
          languageRow(),
          labelRow(Icons.map_outlined, 'Bordering Countries'),
          GetBuilder<CountryDetailController>(builder: (_) {
            return neigbourRow();
          }),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  // handle the flags shown at the bottom of the detail page
  // allowing the flags to be selected and using that info to load the country
  Container neigbourRow() {
    var contl = Get.find<CountriesController>();
    controller.borderInfo = contl.getBorderFlagUrl(controller.country.borders);
    var noBorders = controller.borderInfo.length;
    return Container(
      height: 80,
      child: noBorders == 0 //no borders no show
          ? Container()
          : ListView.builder(
              itemCount: noBorders,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  // selecting a border flag loads that coutries details
                  onPressed: () {
                    controller.country = contl
                        .getCountryDetail(controller.borderInfo[index].name);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: controller.borderInfo[index].flagUrl != null
                        ? svgPicture(controller.borderInfo[index].flagUrl, 80.0,
                            controller.borderInfo[index].borderCode)
                        : Image.asset('assets/images/blankflag.png'),
                  ),
                );
              },
            ),
    );
  }

  // display the national languages of the country in a grid format
  Padding languageRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetX(builder: (_) {
        return controller.country.languages == null
            ? Container()
            : GridView.builder(
                shrinkWrap: true,
                itemCount: controller.country.languages.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2.4),
                //primary: false,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(1, 1, 1, 1),
                      height: 5.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.cyan[400], Colors.blue[700]],
                          stops: [0.0, 0.6],
                        ),
                        //color: Colors.blue[600],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 0.0,
                            blurRadius: 0.0,
                            offset: Offset(0, 0),
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //SizedBox(width: 12),
                            SizedBox(height: 3),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                controller.country.languages[index].name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                            ),
                            //SizedBox(width: 1),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                '(${controller.country.languages[index].nativeName})',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
      }),
    );
  }

  // Reusable label to highlight secions
  Widget labelRow(
    IconData labelIcon,
    String labelText,
  ) {
    return Align(
      alignment: Alignment.centerLeft,
      child: UnconstrainedBox(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 10, 3, 10),
            decoration: BoxDecoration(
              color: Colors.green[700],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 12),
                  IconTheme(
                    data: IconThemeData(
                      color: Colors.white,
                    ),
                    child: Icon(labelIcon),
                  ),
                  SizedBox(width: 12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      labelText,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 18.0),
                    ),
                  ),
                  SizedBox(width: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //reusable info block used to for sub region and capital information
  Widget infoRow(IconData infoIcon, String heading, String infoField) {
    return Column(
      children: [
        ListTile(
          leading: Icon(infoIcon),
          title: Text(heading),
          subtitle: Text(
            infoField,
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
        Divider(
          indent: 70,
          thickness: 2.0,
          height: 1.0,
        ),
      ],
    );
  }

  // Country description text block
  Widget descriptionRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              spreadRadius: 1.0,
              blurRadius: 1.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetX(builder: (_) {
            return Text(
              controller.getDescription(),
              style: TextStyle(height: 1.5),
            );
          }),
        ),
      ),
    );
  }

  //display the country flag
  Widget flagRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: controller.country.flagUrl != null
            ? svgPicture(
                controller.country.flagUrl,
                500.0,
                controller.country.code,
              )
            : Image.asset('assets/images/blankflag.png'),
      ),
    );
  }

  //display the country name, sub region and code
  Widget nameRow() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 8, 8),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetX(builder: (contrller) {
                return Text(
                  controller.country.code,
                  style: TextStyle(
                      color: Colors.grey[100],
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                );
              }),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blueGrey[500],
              ),
              color: Colors.blueGrey[500],
            ),
            padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GetX(builder: (contrller) {
              return Text(
                controller.country.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              );
            }),
            GetX(builder: (contrller) {
              return Text(
                controller.country.subRegion,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 10.0,
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}
