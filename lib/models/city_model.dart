
class CityModel {

  String cityName;
  String districtName;
  String schoolName;

  CityModel({this.cityName, this.districtName, this.schoolName});

  factory CityModel.fromJson(Map<dynamic, dynamic> json) {
    return CityModel(
      cityName : json['City'] as String,
      districtName : json['District'] as String,
      schoolName : json['School'] as String,
    );
  }

}