import 'package:get_storage/get_storage.dart';

class GetStorageServices {
  static GetStorage getStorage = GetStorage();
  static clearStorage() {
    getStorage.erase();
  }

  static setUserName({required String username}) {
    getStorage.write('username', username);
  }

  static getUserName() {
    return getStorage.read('username');
  }

  static setUserLoggedIn() {
    getStorage.write('isUserLoggedIn', true);
  }

  static getUserLoggedInStatus() {
    return getStorage.read('isUserLoggedIn');
  }

  /// user uid
  static setToken(String userUid) {
    getStorage.write('token', userUid);
  }

  static getToken() {
    return getStorage.read('token');
  }

  /// profile image
  static setProfileImageValue(String LoginValue) {
    getStorage.write('setProfileImage', LoginValue);
  }

  static getProfileImageValue() {
    return getStorage.read('setProfileImage');
  }

  /// name image
  static setNameValue(String LoginValue) {
    getStorage.write('setNameValue', LoginValue);
  }

  static getNameValue() {
    return getStorage.read('setNameValue');
  }
}
