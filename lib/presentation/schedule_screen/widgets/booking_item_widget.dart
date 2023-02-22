import 'package:elssit/core/utils/image_constant.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/color_constant.dart';

Widget bookingItemWidget(BuildContext context, String value) {
  var size = MediaQuery.of(context).size;
  return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      padding: EdgeInsets.all(size.height * 0.01),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(size.height * 0.02),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageConstant.icScheduleItem,
            width: size.height * 0.14,
            height: size.height * 0.14,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time,
                    size: size.height * 0.03,
                    color: Colors.black.withOpacity(0.8),
                  ),
                  Text(
                    "12:00 - 16:00",
                    style: GoogleFonts.roboto(
                      color: Colors.black87,
                      fontSize: size.height * 0.018,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: size.width * 0.03,
                  right: size.width * 0.03,
                  top: size.height * 0.005,
                  bottom: size.height * 0.005,
                ),
                decoration: BoxDecoration(
                  color: ColorConstant.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(size.height * 0.01),
                ),
                child: Text(
                  "Sắp tới",
                  style: GoogleFonts.roboto(
                    color: ColorConstant.primaryColor,
                    fontSize: size.height * 0.018,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(size.height * 0.008),
            decoration: BoxDecoration(
              color: ColorConstant.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.more_horiz,
              size: size.height * 0.02,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
        ],
      ));
}
