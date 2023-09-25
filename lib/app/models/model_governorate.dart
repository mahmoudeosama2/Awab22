class Governorate {
  String? id;
  String? governorateNameAr;
  String? governorateNameEn;
  double? lat;
  double? long;

  Governorate(
      {this.id,
      this.governorateNameAr,
      this.governorateNameEn,
      this.lat,
      this.long});

  Governorate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    governorateNameAr = json['governorate_name_ar'];
    governorateNameEn = json['governorate_name_en'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['governorate_name_ar'] = this.governorateNameAr;
    data['governorate_name_en'] = this.governorateNameEn;
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}
