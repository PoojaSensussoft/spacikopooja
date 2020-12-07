class Validation {

  static bool isValidEmail(String email) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  static bool isNameEmpty(String name) {
    if (name.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static bool isPasswordValid(String password) {
    if (password.isEmpty || password.length <= 6) {
      return true;
    } else {
      return false;
    }
  }

  static bool isValidMobile(String mobile) {
    if (mobile.isEmpty || mobile.length != 10) {
      return true;
    } else {
      return false;
    }
  }

  static bool isConfirmPWD(String pass, String confPWD) {
    if (confPWD.isEmpty || pass!=confPWD) {
      return true;
    } else {
      return false;
    }
  }

  static bool isTermsCond(bool ischecked){
    if(ischecked){
      return true;
    }else{
      return false;
    }
  }

}
