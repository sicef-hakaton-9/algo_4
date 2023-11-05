import 'package:sicef_hakaton/services/network_services.dart';

class UserServices {
  static Future<void> login(String email, String pass) async {
    try {
      await NetworkService.auth
          .signInWithEmailAndPassword(email: email, password: pass);
    } catch (e) {
      print('asdasd');
      throw ('ne radi');
    }
  }

  static Future<void> logout() async {
    try {
      await NetworkService.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> register(String name, String email, String pass) async {
    try {
      await NetworkService.auth
          .createUserWithEmailAndPassword(email: email, password: pass);
      await NetworkService.auth.currentUser!.updateDisplayName(name);
    } catch (e) {
      rethrow;
    }
  }
}
