RegExp firstNameLastNameRegularExpression = RegExp(r"^[A-Za-z]+$");
RegExp emailRegularExpression = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+");
RegExp passwordRegularExpression =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
RegExp mobileNumberRegularExpression = RegExp(r"^[0-9]+$");
