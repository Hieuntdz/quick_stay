class BannerData {
  int id;
  String name;
  String type;
  Null param;
  String startTime;
  String endTime;
  String image;
  int isActive;
  Null rules;

  BannerData(
      {this.id, this.name, this.type, this.param, this.startTime, this.endTime, this.image, this.isActive, this.rules});

  BannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    param = json['param'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    image = json['image'];
    isActive = json['is_active'];
    rules = json['rules'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['param'] = this.param;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['image'] = this.image;
    data['is_active'] = this.isActive;
    data['rules'] = this.rules;
    return data;
  }
}
