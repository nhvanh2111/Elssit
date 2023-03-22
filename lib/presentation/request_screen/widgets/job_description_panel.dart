import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDescriptionPanel extends StatefulWidget {
  const JobDescriptionPanel({Key? key}) : super(key: key);

  @override
  State<JobDescriptionPanel> createState() => _JobDescriptionPanelState();
}

class _JobDescriptionPanelState extends State<JobDescriptionPanel> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.only(
            left: size.width * 0.05,
            right: size.width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                color: Colors.white,
                child: ListView.separated(
                  padding: EdgeInsets.only(
                    top: size.height * 0.01,
                    left: size.width * 0.05,
                  ),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Nội dung gì đó",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: size.height * 0.02,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: size.height * 0.01,
                  ),
                  itemCount: 10,
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
            ],
          ),
        );
      },
    );
  }
}
