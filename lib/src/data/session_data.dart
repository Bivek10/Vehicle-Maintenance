import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String userID = "userid";

  Future<String?> getUserID() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String? userid = sharedPreferences.getString(this.userID) ?? null;
    //print(token);
    return userid;
  }

  Future<void> setUserID(String userid) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString(userID, userid);
  }

  Future<void> deleteUserID() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey(userID)) {
      sharedPreferences.remove(userID);
    }
  }
}
