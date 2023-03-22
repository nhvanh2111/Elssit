import 'package:elssit/core/models/package_models/package_all_data_model.dart';
import 'package:elssit/presentation/widget/dialog/custom_checkbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/utils/color_constant.dart';

Widget packageItem(BuildContext context, PackageAllDataModel package) {
  var size = MediaQuery.of(context).size;
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Container(
      //   margin: EdgeInsets.only(
      //     right: size.width * 0.04,
      //   ),
      //   child: CustomCheckBox(
      //       isChecked: false,
      //       size: 30,
      //       iconSize: 20,
      //       selectedColor: ColorConstant.primaryColor,
      //       selectedIconColor: Colors.white),
      // ),
      Container(
        // margin: EdgeInsets.only(
        //   left: size.width * 0.04,
        // ),
        padding: EdgeInsets.all(size.width * 0.05),
        width: size.width * 0.89,
        height: size.height * 0.21,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(18.5)),
          border: Border.all(
            color: ColorConstant.whiteE3,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.05,
                  height: size.height * 0.03,
                  child: Checkbox(
                    focusColor: ColorConstant.primaryColor,
                    checkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    value: false,
                    onChanged: (bool? value) {},
                    // CustomCheckBox(
                    //     isChecked: false,
                    //     size: 25,
                    //     iconSize: 20,
                    //     selectedColor: ColorConstant.primaryColor,
                    //     selectedIconColor: Colors.white),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Text(
                  package.name,
                  style: GoogleFonts.roboto(
                    color: ColorConstant.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: size.height * 0.024,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward,
                  size: size.height * 0.03,
                  color: ColorConstant.primaryColor,
                ),
              ],
            ),
            Container(
              width: size.width,
              height: 1,
              margin: EdgeInsets.only(
                top: size.height * 0.025,
                bottom: size.height * 0.025,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Thời gian dự kiến:",
                    style: GoogleFonts.roboto(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                      fontSize: size.height * 0.022,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${package.duration} giờ",
                    style: GoogleFonts.roboto(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                      fontSize: size.height * 0.022,
                    ),
                  ),
                ]),
            Padding(padding: EdgeInsets.only(top: size.height * 0.015)),
            Row(children: [
              Text(
                "Giá tiền: ",
                style: GoogleFonts.roboto(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                  fontSize: size.height * 0.022,
                ),
              ),
              const Spacer(),
              Text(
                "${package.price} VNĐ",
                style: GoogleFonts.roboto(
                  color: Colors.black.withOpacity(0.7),
                  fontWeight: FontWeight.w400,
                  fontSize: size.height * 0.022,
                ),
              ),
            ]),
          ],
        ),
      ),
    ],
  );
}
