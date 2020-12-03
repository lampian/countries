import 'package:countries_info/controllers/CountriesController.dart';
import 'package:countries_info/model/country_model.dart';
import 'package:countries_info/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    return Column(
      children: [
        SizedBox(
          height: 6,
        ),
        GetX(
          builder: (_) {
            if (controller.countries.length == 0) {
              return Text('no countries');
            } else {
              return Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, __) => Divider(
                    height: 5.0,
                    thickness: 3.0,
                    indent: 100,
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

  ListTile countryTile(CountryModel aCountry) {
    return ListTile(
      leading: Stack(
        children: [
          aCountry.flagUrl != null
              ? Image.network(aCountry.flagUrl)
              : Image.asset('assets/images/blankflag.png'),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: Container(
              child: Text(
                aCountry.code,
                style: TextStyle(
                    color: Colors.grey[100], fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                color: Colors.blueGrey[500],
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
              ),
              padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
            ),
          ),
        ],
      ),
      title: Text(aCountry.name),
      subtitle: Text(aCountry.capital),
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        size: 12,
      ),
      onTap: () {},
    );
  }
}
