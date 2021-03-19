import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:quick_stay_flutter/app/data/model/response/hotel_category.dart';
import 'package:quick_stay_flutter/app/modules/home/views/banner.dart';
import 'package:quick_stay_flutter/app/modules/home/views/recommend_hotel.dart';
import 'package:quick_stay_flutter/app/modules/home/views/top_highlight_hotel.dart';
import 'package:quick_stay_flutter/app/modules/home/views/voucher_scroll_delegate.dart';
import 'package:quick_stay_flutter/app/utils/const.dart';

import '../controllers/home_controller.dart';

class HomePageView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        left: true,
        top: true,
        bottom: true,
        right: true,
        child: _content(),
      ),
    );
  }

  Widget _content() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _searchView(),
                SizedBox(
                  height: 24,
                ),
                _banner(),
                SizedBox(
                  height: 24,
                ),
                _category(),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: VoucherScrollDelegate(),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 24,
              ),
              TopHighLightHotel(),
              SizedBox(
                height: 24,
              ),
              RecommendHotel(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _voucherView() {
    return Container(
      width: double.infinity,
      height: 50,
      child: Stack(
        children: [
          SvgPicture.asset(
            "assets/images/bg_voucher.svg",
            fit: BoxFit.fill,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 24,
                    ),
                    SvgPicture.asset("assets/images/ic_check.svg"),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: Text(
                        "Ưu đãi giảm 30% giá khi ...",
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.85),
                            fontSize: AppDimen.defaultTextBigSize,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    SvgPicture.asset("assets/images/ic_line.svg"),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.center,
                      width: 65,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        "Đổi",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.55),
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimen.defaultTextSmallSize),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _searchView() {
    return Container(
      height: 48,
      child: Row(
        children: [
          Image.asset(
            "assets/images/ic_logo.png",
            fit: BoxFit.cover,
            width: 39,
            height: 32,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Color(0xffC9E7E5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Tìm kiếm khách sạn",
                      style: TextStyle(color: Color(0xff8F9BB3), fontSize: 15),
                    ),
                  ),
                  Image.asset("assets/images/ic_search.png"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _banner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Khuyến mãi trong tháng",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 176,
          child: BannerView(),
        ),
      ],
    );
  }

  Widget _category() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Bạn có thể tìm kiếm nhanh",
          style: TextStyle(
            color: Color(0xff595959),
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 24,
        ),
        Obx(
          () {
            return Container(
              height: 100,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.listCategory.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  HotelCategory category = controller.listCategory[index];
                  return Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: category.icon,
                          width: 47,
                          height: 52,
                        ),
                        Text(
                          category.name,
                          style: TextStyle(
                              color: Color(0xff262626),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
