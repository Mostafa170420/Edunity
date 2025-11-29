import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences pref;

  static const String kIsOnBoardingShown = 'isOnBoardingShown';
  static const String kUserId = 'kUserId';
  static const String kUserType = 'kUserType';
  static const String kUserImage = 'kUserImage';

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<void> setIsOnBoardingShown(bool isShown) async {
    await setData(kIsOnBoardingShown, isShown);
  }

  static bool? getIsOnBoardingShown() {
    return getData(kIsOnBoardingShown) as bool?;
  }

  static Future<void> setUserId(String uid) async {
    await setData(kUserId, uid);
  }

  static String getUserId() {
    return getData(kUserId) as String;
  }

  static Future<void> setUserType(String type) async {
    await setData(kUserType, type);
  }

  static String getUserType() {
    return getData(kUserType) as String;
  }

  static Future<void> setUserImage(String type) async {
    await setData(kUserImage, type);
  }

  static String? getUserImage() {
    return getData(kUserImage) as String?;
  }

  static Future<void> setData(String key, dynamic value) async {
    if (value is int) {
      await pref.setInt(key, value);
    } else if (value is bool) {
      await pref.setBool(key, value);
    } else if (value is String) {
      await pref.setString(key, value);
    } else if (value is double) {
      await pref.setDouble(key, value);
    } else if (value is List<String>) {
      await pref.setStringList(key, value);
    }
  }

  static dynamic getData(String key) {
    return pref.get(key);
  }

  static Future<bool> clear() {
    return pref.clear();
  }

  static Future<bool> remove(String key) {
    return pref.remove(key);
  }
}
