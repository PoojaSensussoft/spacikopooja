class DatabaseClass {
  static const String columnId = 'id';
  static const String columnFName = 'f_name';
  static const String columnLName = 'l_name';
  static const String columnEmail = 'email';
  static const String colummPassword = 'password';
  static const String colummisCheck = 'isCheck';
  static const String colummLogin_with = 'loginWith';

  String id;
  String f_name;
  String l_name;
  String email;
  String password;
  String isCheck;
  String loginWith;

  DatabaseClass(
      {this.id,
      this.f_name,
      this.l_name,
      this.email,
      this.password,
      this.isCheck,
      this.loginWith});

  factory DatabaseClass.fromMap(Map<String, dynamic> json) => new DatabaseClass(
      id: json[columnId],
      f_name: json[columnFName],
      l_name: json[columnLName],
      email: json[columnEmail],
      password: json[colummPassword],
      isCheck: json[colummisCheck],
      loginWith: json[colummLogin_with]);

  Map<String, dynamic> toMap() => {
        columnId: id,
        columnFName: f_name,
        columnLName: l_name,
        columnEmail: email,
        colummPassword: password,
        colummisCheck: isCheck,
        colummLogin_with: loginWith,
      };
}
