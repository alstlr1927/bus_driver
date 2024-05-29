class Validator {
  static bool isValidEmail(String string) {
    final emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(string);
    return emailValid;
  }

  static bool canProceedLogin({
    required String email,
    required String password,
  }) {
    if (isValidEmail(email) && password.isNotEmpty) {
      return true;
    }
    return false;
  }

  static bool validatePhoneNumber(String value) {
    const pattern = r'^010\d{8}$';
    final regExp = RegExp(pattern);

    if (regExp.hasMatch(value)) {
      return true;
    }

    return false;
  }

  static bool validPasswordPattern(String input) {
    RegExp pattern = RegExp(
        r'^(?=.*[a-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,20}$');

    return pattern.hasMatch(input);
  }

  static bool validNamePattern(String value) {
    RegExp pattern = RegExp(r'^[a-zA-Z가-힣0-9]{1,20}$');

    return pattern.hasMatch(value);
  }

  var kWhiteSpaceRegex = RegExp(r"\s");

  // final RegExp _validCharacters = RegExp(r'^[a-zA-Z0-9_.]*$');
}
