class MyUtils{
  String educationDateFormat(String date){
    List<String> strDate = date.split("-");
    return "Tháng ${strDate[1]}, ${strDate[2]}";
  }
  String convertDOBFromIDCard(String dob){
    return "${dob[4]}${dob[5]}${dob[6]}${dob[7]}-${dob[2]}${dob[3]}-${dob[0]}${dob[1]}";
  }
  String convertInputDate(String date){
    List<String> dateStr = date.split("-");
    return "${dateStr[2]}-${dateStr[1]}-${dateStr[0]}";
  }
}