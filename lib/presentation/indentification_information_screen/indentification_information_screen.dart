import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:elssit/presentation/indentification_information_screen/widgets/qr_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/globals.dart' as globals;

class IndentificationInformationScreen extends StatefulWidget {
  const IndentificationInformationScreen({Key? key}) : super(key: key);

  @override
  State<IndentificationInformationScreen> createState() =>
      _IndentificationInformationScreenState();
}

class _IndentificationInformationScreenState
    extends State<IndentificationInformationScreen> {
  late var _fullnameController = TextEditingController();
  late var _dobController = TextEditingController();
  late var _genderController = TextEditingController();
  late var _idNumberController = TextEditingController();
  bool _isAddFace = false;

  //Face img
  String faceImage = "";
  late File imageFileFace;
  XFile? pickedFileFace;
  UploadTask? uploadTaskFace;

  //IDCard front img
  String idCardFront = "";
  late File imageFileIDCardFront;
  XFile? pickedFileIDCardFront;
  UploadTask? uploadTaskIDCardFront;
  bool isIDCardFrontCheck = false;

  //IDCard back img
  String idCardBack = "";
  late File imageFileIDCardBack;
  XFile? pickedFileIDCardBack;
  UploadTask? uploadTaskIDCardBack;
  bool isIDCardBackCheck = false;

  _getFaceImageFromGallery() async {
    pickedFileFace = (await ImagePicker().pickImage(
      source: ImageSource.camera,
    ));
    if (pickedFileFace != null) {
      setState(() {
        imageFileFace = File(pickedFileFace!.path);
      });
    }
    _isAddFace = true;
    final path = 'els_sitter_images/${pickedFileFace!.name}';
    final file = File(pickedFileFace!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTaskFace = ref.putFile(file);

    final snapshot = await uploadTaskFace!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    faceImage = urlDownload;
    print('Download link Face: $urlDownload');
  }

  _getIDCardFrontImageFromGallery() async {
    pickedFileIDCardFront = (await ImagePicker().pickImage(
      source: ImageSource.camera,
    ));
    if (pickedFileIDCardFront != null) {
      setState(() {
        imageFileIDCardFront = File(pickedFileIDCardFront!.path);
        isIDCardFrontCheck = true;
      });
    }
    final path = 'els_sitter_images/${pickedFileIDCardFront!.name}';
    final file = File(pickedFileIDCardFront!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTaskIDCardFront = ref.putFile(file);

    final snapshot = await uploadTaskIDCardFront!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    idCardFront = urlDownload;
    print('Download link IDCardFront: $urlDownload');
  }

  _getIDCardBackImageFromGallery() async {
    pickedFileIDCardFront = (await ImagePicker().pickImage(
      source: ImageSource.camera,
    ));
    if (pickedFileIDCardBack != null) {
      setState(() {
        imageFileIDCardBack = File(pickedFileIDCardBack!.path);
        isIDCardBackCheck = true;
      });
    }
    final path = 'els_sitter_images/${pickedFileIDCardBack!.name}';
    final file = File(pickedFileIDCardBack!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTaskIDCardBack = ref.putFile(file);

    final snapshot = await uploadTaskIDCardBack!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    idCardBack = urlDownload;
    print('Download link IDCardBack: $urlDownload');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (globals.idString != "") {
      List<String> listInfo = globals.idString.split("|");
      _fullnameController = TextEditingController(text: listInfo[2]);
      _dobController = TextEditingController(text: listInfo[3]);
      _genderController = TextEditingController(text: listInfo[4]);
      _idNumberController = TextEditingController(text: listInfo[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();

    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Material(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              bottomOpacity: 0.0,
              elevation: 0.0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/accountScreen');
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  size: size.height * 0.03,
                  color: Colors.black,
                ),
              ),
              title: Padding(
                padding: EdgeInsets.only(left: size.width * 0.005),
                child: const Text(
                  "Thông tin liên lạc",
                ),
              ),
              titleTextStyle: GoogleFonts.roboto(
                fontSize: size.height * 0.028,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            floatingActionButton: SizedBox(
              width: size.width * 0.9,
              height: size.height * 0.06,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(size.height * 0.03), // <-- Radius
                  ),
                  backgroundColor: ColorConstant.primaryColor,
                  elevation: 1,
                  textStyle: TextStyle(
                    fontSize: size.height * 0.024,
                  ),
                ),
                child: const Text("Lưu"),
              ),
            ),
            body: Container(
              height: size.height,
              width: size.width,
              padding: EdgeInsets.only(
                left: size.width * 0.07,
                right: size.width * 0.07,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (!_isAddFace)
                        ? Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.03,
                            ),
                            child: Container(
                              height: size.height * 0.12,
                              width: size.height * 0.12,
                              decoration: BoxDecoration(
                                color:
                                    ColorConstant.primaryColor.withOpacity(0.2),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      ImageConstant.icPersonalDetail),
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: size.height * 0.08,
                                        left: size.height * 0.08,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          _getFaceImageFromGallery();
                                        },
                                        child: Image.asset(
                                          ImageConstant.icEditAvator,
                                          width: size.width * 0.08,
                                          height: size.width * 0.08,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.03,
                            ),
                            child: Container(
                              height: size.height * 0.12,
                              width: size.height * 0.12,
                              decoration: BoxDecoration(
                                color:
                                    ColorConstant.primaryColor.withOpacity(0.2),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: FileImage(imageFileFace),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: size.height * 0.08,
                                        left: size.height * 0.08,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          _getFaceImageFromGallery();
                                        },
                                        child: Image.asset(
                                          ImageConstant.icEditAvator,
                                          width: size.width * 0.08,
                                          height: size.width * 0.08,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.02,
                      ),
                      child: SizedBox(
                        width: size.width * 0.84,
                        height: size.height * 0.055,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const QRViewScreen(),
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                ColorConstant.primaryColor.withOpacity(0.7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            textStyle: TextStyle(
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          child: const Text("Quét mã QR tải lên thông tin"),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Họ và tên',
                        style: GoogleFonts.roboto(
                          color: ColorConstant.gray43,
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteF3,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Theme(
                        data: theme.copyWith(
                          colorScheme: theme.colorScheme
                              .copyWith(primary: ColorConstant.primaryColor),
                        ),
                        child: TextField(
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          cursorColor: ColorConstant.primaryColor,
                          // ignore: unnecessary_null_comparison
                          controller: (_fullnameController != null)
                              ? _fullnameController
                              : null,
                          // onChanged: (value) {
                          //   _authenBloc.eventController.sink.add(InputUserNameEvent(
                          //       username: value.toString().trim()));
                          // },
                          enabled: false,

                          decoration: InputDecoration(
                            hintText: "Họ và tên",
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                width: 1,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ngày sinh',
                        style: GoogleFonts.roboto(
                          color: ColorConstant.gray43,
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteF3,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Theme(
                        data: theme.copyWith(
                          colorScheme: theme.colorScheme
                              .copyWith(primary: ColorConstant.primaryColor),
                        ),
                        child: TextField(
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          cursorColor: ColorConstant.primaryColor,
                          controller:
                              // ignore: unnecessary_null_comparison
                              (_dobController != null) ? _dobController : null,
                          // onChanged: (value) {
                          //   _authenBloc.eventController.sink.add(InputUserNameEvent(
                          //       username: value.toString().trim()));
                          // },
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: "Ngày tháng năm sinh",
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                width: 1,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Giới tính',
                        style: GoogleFonts.roboto(
                          color: ColorConstant.gray43,
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteF3,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Theme(
                        data: theme.copyWith(
                          colorScheme: theme.colorScheme
                              .copyWith(primary: ColorConstant.primaryColor),
                        ),
                        child: TextField(
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          cursorColor: ColorConstant.primaryColor,
                          // ignore: unnecessary_null_comparison
                          controller: (_genderController != null)
                              ? _genderController
                              : null,
                          // onChanged: (value) {
                          //   _authenBloc.eventController.sink.add(InputUserNameEvent(
                          //       username: value.toString().trim()));
                          // },
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: "Giới tính",
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                width: 1,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.025,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'CCCD/CMND',
                        style: GoogleFonts.roboto(
                          color: ColorConstant.gray43,
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteF3,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      child: Theme(
                        data: theme.copyWith(
                          colorScheme: theme.colorScheme
                              .copyWith(primary: ColorConstant.primaryColor),
                        ),
                        child: TextField(
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          cursorColor: ColorConstant.primaryColor,
                          // ignore: unnecessary_null_comparison
                          controller: (_idNumberController != null)
                              ? _idNumberController
                              : null,
                          // onChanged: (value) {
                          //   _authenBloc.eventController.sink.add(InputUserNameEvent(
                          //       username: value.toString().trim()));
                          // },
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: "Căn cước/ Chứng minh",
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                width: 1,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'CCCD/CMND mặt trước',
                        style: GoogleFonts.roboto(
                          color: ColorConstant.gray43,
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    DottedBorder(
                      color: Colors.grey.withOpacity(0.3),
                      dashPattern: const [12, 8],
                      strokeWidth: 1,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(size.height * 0.02),
                      padding: const EdgeInsets.all(0),
                      borderPadding: const EdgeInsets.all(0),
                      child: Container(
                        width: size.width,
                        height: size.height * 0.2,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.15),
                          borderRadius:
                              BorderRadius.circular(size.height * 0.02),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload_file_rounded,
                              color:
                                  ColorConstant.primaryColor.withOpacity(0.8),
                              size: size.height * 0.05,
                            ),
                            const Text("Tải tệp lên"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'CCCD/CMND mặt sau',
                        style: GoogleFonts.roboto(
                          color: ColorConstant.gray43,
                          fontWeight: FontWeight.w400,
                          fontSize: size.height * 0.022,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    DottedBorder(
                      color: Colors.grey.withOpacity(0.3),
                      dashPattern: const [12, 8],
                      strokeWidth: 1,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(size.height * 0.02),
                      padding: const EdgeInsets.all(0),
                      borderPadding: const EdgeInsets.all(0),
                      child: Container(
                        width: size.width,
                        height: size.height * 0.2,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.15),
                          borderRadius:
                              BorderRadius.circular(size.height * 0.02),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload_file_rounded,
                              color:
                                  ColorConstant.primaryColor.withOpacity(0.8),
                              size: size.height * 0.05,
                            ),
                            const Text("Tải tệp lên"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
