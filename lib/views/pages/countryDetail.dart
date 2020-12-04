import 'package:countries_info/controllers/CountriesController.dart';
import 'package:countries_info/model/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../routes.dart';

class CountryDetailPage extends GetWidget<CountriesController> {
  CountryDetailPage(this.name);
  final name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
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
    final theCountry = controller.getCountryDetail(name);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 12),
          nameRow(theCountry),
          SizedBox(height: 10),
          flagRow(theCountry),
          descriptionRow(theCountry),
          SizedBox(height: 12),
          infoRow(
            Icons.location_on_outlined,
            'Sub-region',
            theCountry.subRegion,
          ),
          infoRow(
            Icons.location_city_sharp,
            'Captial',
            theCountry.capital,
          ),
          labelRow(Icons.language_sharp, 'Languages'),
          SizedBox(height: 6),
          languageRow(theCountry),
          labelRow(Icons.map_outlined, 'Bordering Countries'),
          neigbourRow(theCountry.borders),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Container neigbourRow(List<String> borders) {
    final borderInfo = controller.getBorderFlagUrl(borders);
    return Container(
      height: 80,
      child: ListView.builder(
        itemCount: borderInfo.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          //return Text(borderInfo[index].flagUrl);
          return FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            onPressed: () {},
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: borderInfo[index].flagUrl != null
                  ? SvgPicture.network(
                      borderInfo[index].flagUrl,
                      height: 80,
                      placeholderBuilder: (_) =>
                          Image.asset('assets/images/blankflag.png'),
                    )
                  : Image.asset('assets/images/blankflag.png'),
            ),
          );
        },
      ),
    );
  }

  Padding languageRow(CountryModel theCountry) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: theCountry.languages.length,
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
                        theCountry.languages[index].name,
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
                        '(${theCountry.languages[index].nativeName})',
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
      ),
    );
  }

  Align labelRow(
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

  Column infoRow(IconData infoIcon, String heading, String infoField) {
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

  Padding descriptionRow(CountryModel theCountry) {
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
          child: Text(
            controller.getDescription(theCountry),
            style: TextStyle(height: 1.5),
          ),
        ),
      ),
    );
  }

  Padding flagRow(CountryModel theCountry) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: theCountry.flagUrl != null
            ? SvgPicture.network(
                theCountry.flagUrl,
                height: 500,
                placeholderBuilder: (_) =>
                    Image.asset('assets/images/blankflag.png'),
              )
            : Image.asset('assets/images/blankflag.png'),
      ),
    );
  }

  Row nameRow(CountryModel theCountry) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 8, 8),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                theCountry.code,
                style: TextStyle(
                    color: Colors.grey[100],
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
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
            Text(
              theCountry.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              theCountry.subRegion,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 10.0,
              ),
            )
          ],
        ),
      ],
    );
  }
}
