import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quick_stay_flutter/app/utils/const.dart';

class VoucherScrollDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {

    return Container(
      width: double.infinity,
      height: 80,
        margin: EdgeInsets.only(bottom: 24),
      color: Colors.white,
      child: Container(
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
      )
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
