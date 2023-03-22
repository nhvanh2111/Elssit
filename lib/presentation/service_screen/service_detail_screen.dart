import 'package:elssit/core/utils/color_constant.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({Key? key}) : super(key: key);

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            size: size.height * 0.03,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/packageScreen');
          },
        ),
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Chi tiết gói dịch vụ",
          ),
        ),
        titleTextStyle: GoogleFonts.roboto(
          fontSize: size.height * 0.028,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      body: Material(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.01,
            ),
            ListView.builder(
              padding: EdgeInsets.only(
                left: size.width * 0.05,
                right: size.width * 0.05,
                //top: size.height * 0.03,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) => packageservicedetail(context),
              // physics: const BouncingScrollPhysics(),
              // shrinkWrap: true,
              // itemBuilder: (context, index) => packageservicedetail(context),
            ),
          ],
        ),
        //),
      ),
    );
  }
}

packageservicedetail(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      children: [
        const CircleAvatar(
          radius: 12,
          backgroundColor: Color(0xFFF1F9F1),
          child: Icon(
            Icons.done,
            size: 17,
            color: Color(0xFF5CB85C),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          "4 Eggs",
          //style: Theme.of(context).textTheme.bodyText2,
          //"${service.name}",
          style: GoogleFonts.roboto(
            color: Colors.black.withOpacity(0.7),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}
