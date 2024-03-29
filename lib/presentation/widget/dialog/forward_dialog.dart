import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/core/utils/image_constant.dart';

Future<void> showForwardDialog(BuildContext context) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageConstant.imgForWard,
                width: size.width * 0.64,
                height: size.width * 0.5,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                'Cảnh Báo !',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: ColorConstant.yellowFF,
                  fontWeight: FontWeight.w800,
                  fontSize: size.height * 0.035,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'Bạn phải cập nhật đầy đủ hồ sơ để sử dụng ứng dụng.',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  color: ColorConstant.gray4A,
                  fontWeight: FontWeight.normal,
                  fontSize: size.height * 0.022,
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.yellowFF,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  // ignore: sort_child_properties_last
                  child: Row(children: [

                    Container(
                      width: size.width * 0.44,
                      alignment: Alignment.center,
                      child: Text(
                        'Đi đến trang hồ sơ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.height * 0.02,
                        ),
                      ),
                    ),

                    Icon(
                      Icons.arrow_forward,
                      size: size.height * 0.03,
                      color: Colors.white,
                    ),
                  ]),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/accountScreen')),
            ],
          ),
        )),
      );
    },
  );
}
