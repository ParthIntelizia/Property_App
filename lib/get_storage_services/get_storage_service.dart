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

  /// login value
  static setLoginValue(String LoginValue) {
    getStorage.write('setLoginValue', LoginValue);
  }

  static getLoginValue() {
    return getStorage.read('setLoginValue');
  }
}
