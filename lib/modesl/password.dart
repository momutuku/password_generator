class Password {
  String pswUri;
  String pswName;
  String pswUser;
  String pswLink;
  String pswValue;

  Password({
    required this.pswUri,
    required this.pswName,
    required this.pswUser,
    required this.pswLink,
    required this.pswValue,
  });

  Map<String, dynamic> toMap() {
    return {
      "pswUri": pswUri,
      "pswName": pswName,
      "pswUser": pswUser,
      "pswLink": pswLink,
      "pswValue": pswValue,
    };
  }

  static List<Password> getPasswords() {
    List<Password> passwords = [];
    for (var i = 0; i < 25; i++) {
      Password psw = Password(
          pswUri: i.toString(),
          pswName: "Password $i",
          pswUser: "user$i",
          pswLink: "Link $i",
          pswValue: "Value $i");
      passwords.add(psw);
    }

    return passwords;
  }

  static List<Password> filterPassword(
      List<Password> originalList, bool Function(Password) predicate) {
    return originalList.where(predicate).toList();
  }
}
