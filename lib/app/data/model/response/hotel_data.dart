class HotelData {
  bool hasSpecial;
  int id;
  String name;
  String phone;
  String lat;
  String lng;
  String price;
  String discountPrice;
  String discountPriceOn;
  String afterHour;
  String priceOn;
  String starRate;
  String address;
  double distance;
  String thumbnail;
  int check;
  int isFavorite;
  String totalComment;
  String totalRating;
  bool isAvailableBooking;
  bool isActive;
  int hotelStatus;
  bool hasBookingOvernight;
  String startOvernightTime;
  String endOvernightTime;
  String applyCampaignId;
  int isActiveHour;
  int isActiveOvernight;
  bool isFlashSale;

  HotelData(
      {this.hasSpecial,
        this.id,
        this.name,
        this.phone,
        this.lat,
        this.lng,
        this.price,
        this.discountPrice,
        this.discountPriceOn,
        this.afterHour,
        this.priceOn,
        this.starRate,
        this.address,
        this.distance,
        this.thumbnail,
        this.check,
        this.isFavorite,
        this.totalComment,
        this.totalRating,
        this.isAvailableBooking,
        this.isActive,
        this.hotelStatus,
        this.hasBookingOvernight,
        this.startOvernightTime,
        this.endOvernightTime,
        this.applyCampaignId,
        this.isActiveHour,
        this.isActiveOvernight,
        this.isFlashSale});

  HotelData.fromJson(Map<String, dynamic> json) {
    hasSpecial = json['has_special'];
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    lat = json['lat'];
    lng = json['lng'];
    price = json['price'];
    discountPrice = json['discount_price'];
    discountPriceOn = json['discount_price_on'];
    afterHour = json['after_hour'];
    priceOn = json['price_on'];
    starRate = json['star_rate'];
    address = json['address'];
    distance = json['distance'];
    thumbnail = json['thumbnail'];
    check = json['check'];
    isFavorite = json['is_favorite'];
    totalComment = json['total_comment'];
    totalRating = json['total_rating'];
    isAvailableBooking = json['is_available_booking'];
    isActive = json['is_active'];
    hotelStatus = json['hotel_status'];
    hasBookingOvernight = json['has_booking_overnight'];
    startOvernightTime = json['start_overnight_time'];
    endOvernightTime = json['end_overnight_time'];
    applyCampaignId = json['apply_campaign_id'];
    isActiveHour = json['is_active_hour'];
    isActiveOvernight = json['is_active_overnight'];
    isFlashSale = json['is_flash_sale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['has_special'] = this.hasSpecial;
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['discount_price_on'] = this.discountPriceOn;
    data['after_hour'] = this.afterHour;
    data['price_on'] = this.priceOn;
    data['star_rate'] = this.starRate;
    data['address'] = this.address;
    data['distance'] = this.distance;
    data['thumbnail'] = this.thumbnail;
    data['check'] = this.check;
    data['is_favorite'] = this.isFavorite;
    data['total_comment'] = this.totalComment;
    data['total_rating'] = this.totalRating;
    data['is_available_booking'] = this.isAvailableBooking;
    data['is_active'] = this.isActive;
    data['hotel_status'] = this.hotelStatus;
    data['has_booking_overnight'] = this.hasBookingOvernight;
    data['start_overnight_time'] = this.startOvernightTime;
    data['end_overnight_time'] = this.endOvernightTime;
    data['apply_campaign_id'] = this.applyCampaignId;
    data['is_active_hour'] = this.isActiveHour;
    data['is_active_overnight'] = this.isActiveOvernight;
    data['is_flash_sale'] = this.isFlashSale;
    return data;
  }
}