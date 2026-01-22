import 'package:get_storage/get_storage.dart';

class AuthRepository {
  final _box = GetStorage();

  Future<bool> isLoggedIn() async {
    return _box.read('isLoggedIn') ?? false;
  }

  Future<String> getUserType() async {
    return _box.read('userType') ?? "user"; // default user
  }

  // Call this after login
  Future<void> saveLogin(String type) async {
    await _box.write('isLoggedIn', true);
    await _box.write('userType', type); // "user" or "creator"
  }

  Future<void> logout() async {
    await _box.erase();
  }
}
