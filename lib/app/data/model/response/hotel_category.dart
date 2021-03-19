class HotelCategory {
  int id;
  String name;
  String icon;
  int cityId;
  City city;

  HotelCategory({this.id, this.name, this.icon, this.cityId, this.city});

  HotelCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    cityId = json['city_id'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['city_id'] = this.cityId;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    return data;
  }
}

class City {
  int id;
  String name;
  String description;
  String lat;
  String lng;
  Null createdAt;
  Null updatedAt;

  City(
      {this.id,
        this.name,
        this.description,
        this.lat,
        this.lng,
        this.createdAt,
        this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}