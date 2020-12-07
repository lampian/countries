import 'dart:convert';

import 'package:countries_info/model/country_model.dart';
import 'package:countries_info/services/api.dart';
import 'package:http/http.dart' as http;

// service to get the country data via rest api.
// the data for his assignmanet is considered slow changing
// improvements could include building a stream to update the
// data when changed at the source
class ApiService {
  ApiService(this.api);
  final API api;

  Future<List<CountryModel>> getEndPointData(EndPoint endPoint) async {
    var countryList = List<CountryModel>();
    final uri = api.endpointUri(endPoint);
    print('uri: $uri');
    try {
      final response = await http.get(uri.toString());
      if (response.statusCode == 200) {
        final List<dynamic> data = await jsonDecode(response.body);
        if (data.isNotEmpty) {
          data.forEach((element) {
            countryList.add(CountryModel.fromJson(element));
          });
        }
      } else {
        // no need to do something special - the higher level code
        // checks the status of the information and retries periodically
        // TODO
        // add some informative messages about what is happening
        print('countries api error: ${response.reasonPhrase}');
      }
    } catch (e) {
      // no need to do something special - the higher level code
      // checks the status of the information and retries periodically
      print('countries api error: $e');
    }
    return countryList;
  }
}
