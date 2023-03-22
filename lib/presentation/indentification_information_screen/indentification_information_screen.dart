import 'dart:io';

import 'package:elssit/core/models/sitter_models/sitter_detail_data_model.dart';
import 'package:elssit/core/utils/my_utils.dart';
import 'package:elssit/process/state/sitter_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/globals.dart' as globals;
import 'package:firebase_storage/firebase_storage.dart';

import 'package:elssit/presentation/indentification_information_screen/widgets/qr_view.dart';
import 'package:elssit/process/bloc/sitter_bloc.dart';
import 'package:elssit/process/event/sitter_event.dart';

class IndentificationInformationScreen extends StatefulWidget {
  const IndentificationInformationScreen({Key? key}) : super(key: key);

  @override
  State<IndentificationInformationScreen> createState() =>
      _IndentificationInformationScreenState();
}

class _IndentificationInformationScreenState
    extends State<IndentificationInformationScreen> {
  late var fullNameController = TextEditingController();
  late var dobController = TextEditingController();
  late var genderController = TextEditingController();
  late var idNumberController = TextEditingController();

  bool _isAddAvatar = false;
  final _sitBloc = SitBloc();

  //Avatar Img
  String avatarImage = "";
  late File imageFileAvatar;
  XFile? pickedFileAvatar;
  UploadTask? uploadTaskAvatar;

  //Front Card Img
  String FrontCardImg = "";
  late File imageFileFrontCardImg;
  XFile? pickedFileFrontCardImg;
  UploadTask? uploadTaskFrontCardImg;
  bool isFrontCardImgCheck = false;

  //Back Card Img
  String BackCardImg = "";
  late File imageFileBackCardImg;
  XFile? pickedFileBackCardImg;
  UploadTask? uploadTaskBackCardImg;
  bool isBackCardImgCheck = false;

  _getavatarImageFromGallery() async {
    pickedFileAvatar = (await ImagePicker().pickImage(
      source: ImageSource.camera,
    ));
    if (pickedFileAvatar != null) {
      setState(() {
        imageFileAvatar = File(pickedFileAvatar!.path);
      });
    }
    _isAddAvatar = true;
    final path = 'els_sitter_images/${pickedFileAvatar!.name}';
    final file = File(pickedFileAvatar!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTaskAvatar = ref.putFile(file);

    final snapshot = await uploadTaskAvatar!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    avatarImage = urlDownload;
    _sitBloc.eventController.sink
        .add(AvatarImgSitEvent(avatarImg: avatarImage));
  }

  _getIDCardBackImageFromGallery() async {
    pickedFileBackCardImg = (await ImagePicker().pickImage(
      source: ImageSource.camera,
    ));
    if (pickedFileBackCardImg != null) {
      setState(() {
        imageFileBackCardImg = File(pickedFileBackCardImg!.path);
        isBackCardImgCheck = true;
      });
    }
    final path = 'els_sitter_images/${pickedFileBackCardImg!.name}';
    final file = File(pickedFileBackCardImg!.path);
    final ref = FirebaseStorage.instance.ref().child(path);

    uploadTaskBackCardImg = ref.putFile(file);
    final snapshot = await uploadTaskBackCardImg!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    BackCardImg = urlDownload;
    _sitBloc.eventController.sink
        .add(BackCardImgSitEvent(backCardImg: BackCardImg));
  }

  _getIDCardFrontImageFromGallery() async {
    pickedFileFrontCardImg = (await ImagePicker().pickImage(
      source: ImageSource.camera,
    ));
    if (pickedFileFrontCardImg != null) {
      setState(() {
        imageFileFrontCardImg = File(pickedFileFrontCardImg!.path);
      });
    }
    isFrontCardImgCheck = true;
    final path = 'els_sitter_images/${pickedFileFrontCardImg!.name}';
    final file = File(pickedFileFrontCardImg!.path);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTaskFrontCardImg = ref.putFile(file);

    final snapshot = await uploadTaskFrontCardImg!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    FrontCardImg = urlDownload;
    _sitBloc.eventController.sink
        .add(FrontCardImgSitEvent(frontCardImg: FrontCardImg));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (globals.idString != "") {
      List<String> listInfo = globals.idString.split("|");
      fullNameController = TextEditingController(text: listInfo[2]);
      _sitBloc.eventController.sink
          .add(FillFullNameSitEvent(fullName: listInfo[2]));
      dobController = TextEditingController(
          text: MyUtils().convertDOBFromIDCard(listInfo[3]));
      _sitBloc.eventController.sink.add(
          FillDobSitEvent(dob: MyUtils().convertDOBFromIDCard(listInfo[3])));
      genderController = TextEditingController(text: listInfo[4]);
      _sitBloc.eventController.sink
          .add(FillGenderSitEvent(gender: listInfo[4]));
      idNumberController = TextEditingController(text: listInfo[0]);
      _sitBloc.eventController.sink
          .add(FillIdNumberSitEvent(idNumber: listInfo[0]));
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return StreamBuilder<SitState>(
      stream: _sitBloc.stateController.stream,
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
                  "Thông tin định danh",
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
                onPressed: () {
                  _sitBloc.eventController.sink
                      .add(UpdateInformationDetailSitEvent(context: context));
                },
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
                    (!_isAddAvatar)
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
                                          _getavatarImageFromGallery();
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
                                  image: FileImage(imageFileAvatar),
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
                                          _getavatarImageFromGallery();
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
                    (snapshot.hasError &&
                            (snapshot.error as Map<String, String>)
                                .containsKey("avatarImg"))
                        ? SizedBox(
                            width: size.width,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                              ),
                              child: Text(
                                (snapshot.error
                                    as Map<String, String>)["avatarImg"]!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.redFail,
                                  fontSize: size.height * 0.016,
                                  height: 0.01,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
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
                    (snapshot.hasError &&
                            (snapshot.error as Map<String, String>)
                                .containsKey("qr"))
                        ? SizedBox(
                            width: size.width,
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: size.height * 0.02,
                              ),
                              child: Text(
                                (snapshot.error as Map<String, String>)["qr"]!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ColorConstant.redErrorText,
                                  fontSize: size.height * 0.016,
                                  height: 0.01,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
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
                          controller: (fullNameController != null)
                              ? fullNameController
                              : null,
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
                              (dobController != null) ? dobController : null,
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
                          controller: (genderController != null)
                              ? genderController
                              : null,
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
                          controller: (idNumberController != null)
                              ? idNumberController
                              : null,
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
                    (!isFrontCardImgCheck)
                        ? DottedBorder(
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
                              child: GestureDetector(
                                onTap: () {
                                  _getIDCardFrontImageFromGallery();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload_file_rounded,
                                      color: ColorConstant.primaryColor
                                          .withOpacity(0.8),
                                      size: size.height * 0.05,
                                    ),
                                    const Text("Tải tệp lên"),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : DottedBorder(
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
                                image: DecorationImage(
                                    image: FileImage(imageFileFrontCardImg),
                                    fit: BoxFit.fill),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _getIDCardFrontImageFromGallery();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload_file_rounded,
                                      color: ColorConstant.primaryColor
                                          .withOpacity(0.8),
                                      size: size.height * 0.05,
                                    ),
                                    const Text("Tải tệp lên"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    (snapshot.hasError &&
                            (snapshot.error as Map<String, String>)
                                .containsKey("frontCardImg"))
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              (snapshot.error
                                  as Map<String, String>)["frontCardImg"]!,
                              style: TextStyle(
                                color: ColorConstant.redFail,
                                fontSize: size.height * 0.017,
                              ),
                            ),
                          )
                        : const SizedBox(),
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
                    (!isBackCardImgCheck)
                        ? DottedBorder(
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
                              child: GestureDetector(
                                onTap: () {
                                  _getIDCardBackImageFromGallery();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload_file_rounded,
                                      color: ColorConstant.primaryColor
                                          .withOpacity(0.8),
                                      size: size.height * 0.05,
                                    ),
                                    const Text("Tải tệp lên"),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : DottedBorder(
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
                                image: DecorationImage(
                                    image: FileImage(imageFileBackCardImg),
                                    fit: BoxFit.fill),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _getIDCardBackImageFromGallery();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload_file_rounded,
                                      color: ColorConstant.primaryColor
                                          .withOpacity(0.8),
                                      size: size.height * 0.05,
                                    ),
                                    const Text("Tải tệp lên"),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    (snapshot.hasError &&
                            (snapshot.error as Map<String, String>)
                                .containsKey("backCardImg"))
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              (snapshot.error
                                  as Map<String, String>)["backCardImg"]!,
                              style: TextStyle(
                                color: ColorConstant.redFail,
                                fontSize: size.height * 0.017,
                              ),
                            ),
                          )
                        : const SizedBox(),
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
