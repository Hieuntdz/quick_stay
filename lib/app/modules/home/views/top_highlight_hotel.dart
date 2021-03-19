import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quick_stay_flutter/app/data/model/response/hotel_data.dart';
import 'package:quick_stay_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:quick_stay_flutter/app/utils/const.dart';
import 'package:quick_stay_flutter/app/utils/helper.dart';
import 'package:quick_stay_flutter/generated/locales.g.dart';

class TopHighLightHotel extends StatelessWidget {
  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.top_high_light_hotel.tr,
          style: TextStyle(
              color: Color(0xff36353E),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          width: double.infinity,
          height: 146,
          child: Obx(
            () => ListView.separated(
              itemCount: controller.listHighLightHotel.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                HotelData data = controller.listHighLightHotel[index];
                return _itemHighLightHotel(data);
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: 16,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

Widget _itemHighLightHotel(HotelData data) {
  return Container(
    width: 248,
    height: 146,
    child: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child:  Helper.loadImage(data.thumbnail,fit: BoxFit.fill),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.only(left: 12, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data.name ?? "",
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: AppDimen.defaultTextBigSize,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    SvgPicture.asset("assets/images/ic_location.svg"),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Text(
                        data.address ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: AppDimen.defaultTextNormalSize),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
