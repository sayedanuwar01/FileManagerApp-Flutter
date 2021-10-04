

class UserModel {

  String userId;
  String firstName;
  String surName;
  String birthDay;
  String alan;
  String className;
  String phoneNumber;
  String emailAddress;
  String district;
  String cityName;
  String school;
  String gender;
  String imgurl;
  String localLoad;

  UserModel({
    this.userId = '', this.firstName = '', this.surName = '', this.birthDay = '', this.alan = '', this.className = '', this.phoneNumber = '',
    this.emailAddress = '', this.district = '', this.cityName = '', this.school = '', this.gender = '', this.imgurl = '', this.localLoad
  });

  fromJson(Map<dynamic, dynamic> json){
    userId = json['userId'] as String;
    firstName = json['firstName'] as String;
    surName = json['surName'] as String;
    birthDay = json['birthDay'] as String;
    alan = json['alan'] as String;
    className = json['className'] as String;
    phoneNumber = json['phoneNumber'] as String;
    emailAddress = json['emailAddress'] as String;
    district = json['district'] as String;
    cityName = json['cityName'] as String;
    school = json['school'] as String;
    gender = json['gender'] as String;
    imgurl = json['imgurl'] as String;
    localLoad = json['localLoad'] as String;
  }

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      userId : json['userId'] as String,
      firstName : json['firstName'] as String,
      surName : json['surName'] as String,
      birthDay : json['birthDay'] as String,
      alan : json['alan'] as String,
      className : json['className'] as String,
      phoneNumber : json['phoneNumber'] as String,
      emailAddress : json['emailAddress'] as String,
      district : json['district'] as String,
      cityName : json['cityName'] as String,
      school : json['school'] as String,
      gender : json['gender'] as String,
      imgurl : json['imgurl'] as String,
      localLoad : json['localLoad'] as String,
    );
  }

  toJson() {
    return {
      "userId": userId,
      "firstName" : firstName,
      "surName": surName,
      "birthDay": birthDay,
      "alan": alan,
      "className": className,
      "phoneNumber": phoneNumber,
      "emailAddress": emailAddress,
      "district": district,
      "cityName": cityName,
      "school": school,
      "gender": gender,
      "imgurl": imgurl,
      "localLoad" : localLoad
    };
  }

  copyWith({
    String userId, String firstName, String surName, String birthDay, String alan, String className
    , String phoneNumber, String emailAddress, String district, String cityName, String school
    , String privacyText, String gender, String imgurl, String localLoad}) {

    return new UserModel(
      userId: userId?? this.userId,
      firstName: firstName?? this.firstName,
      surName: surName?? this.surName,
      birthDay: birthDay?? this.birthDay,
      alan: alan?? this.alan,
      className: className?? this.className,
      phoneNumber: phoneNumber?? this.phoneNumber,
      emailAddress: emailAddress?? this.emailAddress,
      district: district?? this.district,
      cityName: cityName?? this.cityName,
      school: school?? this.school,
      gender: gender?? this.gender,
      imgurl: imgurl?? this.imgurl,
      localLoad: localLoad?? this.localLoad,
    );
  }

}