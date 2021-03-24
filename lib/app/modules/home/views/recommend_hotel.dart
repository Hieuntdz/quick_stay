import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quick_stay_flutter/app/data/model/response/hotel_data.dart';
import 'package:quick_stay_flutter/app/modules/common/star_rating.dart';
import 'package:quick_stay_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:quick_stay_flutter/app/utils/const.dart';
import 'package:quick_stay_flutter/app/utils/helper.dart';
import 'package:quick_stay_flutter/app/utils/logger.dart';
import 'package:quick_stay_flutter/generated/locales.g.dart';

class RecommendHotel extends StatelessWidget {
  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.recommend_hotel.tr,
          style: TextStyle(
              color: Color(0xff36353E),
              fontSize: AppDimen.defaultTextBigSize,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 17,
        ),
        Obx(
          () {
            int count = controller.listRecommendHotel.length;
            if (count > 0) {
              count = count + 1;
            }
            return ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              itemCount: count,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                if (index < count - 1) {
                  HotelData data = controller.listRecommendHotel[index];
                  return _itemHotelRecommend(data);
                } else {
                  return _showMore();
                }
              },
              separatorBuilder: (context, index) {
                if (index < count - 2) {
                  return Container(
                    margin: EdgeInsets.only(top: 16, bottom: 16),
                    width: double.infinity,
                    height: 1,
                    color: Color(0xff8F9BB3).withOpacity(0.24),
                  );
                } else {
                  return Container(
                    height: 20,
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}

Widget _showMore() {
  Logger.debug("start");
  return Align(
    alignment: Alignment.center,
    child: Container(
      alignment: Alignment.center,
      width: 120,
      margin: EdgeInsets.only(bottom: 100),
      decoration: BoxDecoration(
        color: Color(0xffC9E7E5),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
      child: Text(
        LocaleKeys.show_more.tr,
        style: TextStyle(
            color: Color(0xffE56024), fontSize: AppDimen.defaultTextNormalSize),
      ),
    ),
  );
}

Widget _itemHotelRecommend(HotelData data) {
  return Container(
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 128,
                    height: 174,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Helper.loadImage(data.thumbnail, fit: BoxFit.fill),
                    ),
                  ),
                  Visibility(
                    visible: data.isFlashSale,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 32,
                        height: 32,
                        color: Color(0xffFAB516),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          child: SvgPicture.asset("assets/images/ic_flash.svg"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              _buttonViewRoom()
            ],
          ),
          SizedBox(
            width: 24,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: TextStyle(
                      color: Color(0xff2E3A59),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                rattingView(data),
                textWithLeftIcon(
                    "assets/images/ic_loaction_grey.svg", data.address),
                SizedBox(
                  height: 8,
                ),
                textWithLeftIcon("assets/images/ic_near_me.svg",
                    "Cách tôi ${data.distance} km"),
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                priceWidget(data),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

final Shader linearGradient = LinearGradient(
  colors: <Color>[Color(0xfff79043), Color(0xfff5784d), Color(0xfff36456)],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

Widget priceWidget(HotelData hotelData) {

  var price = int.parse(hotelData.price);
  var priceOn = int.parse(hotelData.priceOn);

  var discountPrice = double.parse(hotelData.discountPrice);
  var discountPriceOn = double.parse(hotelData.discountPriceOn);

  return Container(
    alignment: Alignment.bottomRight,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "2h đầu: ",
                style: TextStyle(
                    color: Color(0xff8F9BB3),
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              TextSpan(
                text: "${hotelData.price} đ",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    foreground: Paint()..shader = linearGradient),
              ),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Qua đêm: ",
                style: TextStyle(
                    color: Color(0xff8F9BB3),
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
              TextSpan(
                text: "${hotelData.priceOn} đ",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color(0xff36353E),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget textWithLeftIcon(String icon, String text) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      SvgPicture.asset(icon),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
              color: Color(0xff2E3A59),
              fontSize: AppDimen.defaultTextNormalSize,
              fontWeight: FontWeight.w500),
        ),
      ),
    ],
  );
}

Widget _buttonViewRoom() {
  return Container(
    padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xfff26158),
            Color(0xfff57a4d),
            Color(0xfff89242),
          ],
        )),
    alignment: Alignment.center,
    child: Text(LocaleKeys.view_room.tr,
        style: TextStyle(
            color: Colors.white, fontSize: AppDimen.defaultTextNormalSize)),
  );
}

Widget rattingView(HotelData data) {
  double star = double.parse(data.starRate);
  return Row(
    children: [
      StarRating(
        rating: star,
        color: Colors.amber,
      ),
      SizedBox(
        width: 16,
      ),
      SvgPicture.asset("assets/images/ic_star_count.svg"),
      SizedBox(
        width: 1,
      ),
      Text(
        data.totalRating,
        style: TextStyle(
            color: Color(0xff8F9BB3), fontSize: AppDimen.defaultTextNormalSize),
      ),
      SizedBox(
        width: 16,
      ),
      SvgPicture.asset("assets/images/ic_message.svg"),
      SizedBox(
        width: 1,
      ),
      Text(
        data.totalComment,
        style: TextStyle(
            color: Color(0xff8F9BB3), fontSize: AppDimen.defaultTextNormalSize),
      )
    ],
  );
}
