import 'dart:async';
import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'location.dart';

/// Network related class where all your API calls are handled
/// Here we fetch a list of locations for the chosen city and show it
/// to the user on the locations screen

class AqiClient {

  final _host = 'api.openaq.org';

  Map<String, String> get _headers => {'Accept': 'application/json'};

  ///Define the path and parameters for the API call here
  Future<List<Location>> fetchLocations(String city, int page) async {
    try {
      final data = await request(path: 'v1/measurements', parameters: {
        'city': city,
        'parameter': 'pm25',
        'country': 'IN',
        'page': page.toString(),
        'limit': "10"
      });

      final locations = data['results'];
      return locations
          .map<Location>((json) => Location.fromJson(json))
          .toList(growable: false);
    }catch(err){
      return [];
    }
  }

  Future<Map> request(
      {@required String path, Map<String, String> parameters}) async {
    final uri = Uri.https(_host, '$path', parameters);
    final results = await http.get(uri, headers: _headers);
    final jsonObject = json.decode(results.body);
    return jsonObject;
  }
}
