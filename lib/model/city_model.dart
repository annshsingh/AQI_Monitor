class CityModel {
  String city;

  CityModel({
    this.city,
  });

  CityModel.fromJson(Map<String, dynamic> json) {
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    return data;
  }

  String toQueryParam() {
    return Uri(queryParameters: toJson()).query;
  }

  CityModel.fromQueryParam(Map<String, dynamic> jsonMap) {
    city = jsonMap['city']?.first;
  }
}
