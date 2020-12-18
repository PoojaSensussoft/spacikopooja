class Tables {
  static String CREATE_TABLE_USERS =
      "CREATE TABLE IF NOT EXISTS test_spaciko (" +
          "id				        INTEGER PRIMARY KEY AUTOINCREMENT," +
          "f_name				      TEXT," +
          "l_name				    TEXT" +
          "email				    TEXT" +
          "password				    TEXT" +
          "isCheck				    TEXT" +
          "loginWith				    TEXT" +
          ")";
}
