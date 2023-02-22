
class Validations{

  static bool isValidEmail(String email) {
    RegExp emailRegex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      caseSensitive: false,
      multiLine: false,
    );
    if(emailRegex.hasMatch(email) && email.isNotEmpty){
      return true;
    }
    return false;
  }

  static bool isValidPassword(String password) {
    RegExp passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$',
      caseSensitive: false,
      multiLine: false,
    );
    if(passwordRegex.hasMatch(password) && password.isNotEmpty){
      return true;
    }
    return false;
  }

}