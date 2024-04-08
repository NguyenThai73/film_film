import 'package:rxdart/rxdart.dart';
import 'package:service_user/service_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'repository_user.dart';

class AuthenticationRepository {
  final ServiceUser serviceUser = ServiceUser();

  AuthenticationRepository({
    UserRepository? userRepository,
  }) : _userRepository = userRepository ?? UserRepository();

  final UserRepository _userRepository;
  final userForAuthenChange = BehaviorSubject<UserModel?>();
  bool isRegister = false;
  String? tokenFirebase;
  Stream<UserModel?> get userForAuthen {
    return userForAuthenChange.stream;
  }

  Stream<UserModel?> get user {
    return _userRepository.user;
  }

  UserModel? get currentUser {
    return _userRepository.getUser();
  }

  UserModel updateUer(UserModel userModel) {
    userChange(userModel);
    _userRepository.updateUser(userModel);
    return userModel;
  }

  userChange(UserModel userModel) {
    userForAuthenChange.add(userModel);
  }

  Future<void> logOut() async {
    requestEmptyUser();
    serviceUser.signOut();
  }

  void requestEmptyUser() {
    userForAuthenChange.add(null);
    _userRepository.updateUser(null);
  }

  void updateUserFromTutorial() {
    final user = _userRepository.getUser();
    userForAuthenChange.add(user);
  }

  Future<UserModel?> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var response = await _userRepository.register(
        email: email, password: password, name: name);
    if (response != null) {
      await prefs.setString("email", email);
      await prefs.setString("pass", password);
      updateUer(response);
    }
    return response;
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var response =
        await _userRepository.login(email: email, password: password);
    if (response != null) {
      await prefs.setString("email", email);
      await prefs.setString("pass", password);
      updateUer(response);
    } else {
      requestEmptyUser();
    }
    return response;
  }

  Future<bool> changePass(String newPass) async {
    var check = await _userRepository.changePass(newPass);
    if (check) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("pass", newPass);
    }
    return check;
  }

  Future<bool> deteteAccount(UserModel userModel) async {
    return await serviceUser.deteteAccount(userModel);
  }

  updateImage({String? imageUrl}) async {
    var userNew = await serviceUser.updateImage(imageUrl: imageUrl);
    if (userNew != null) {
      _userRepository.updateUser(userNew);
    }
  }

  updateName(String name) async {
    var userNew = await serviceUser.updateName(name: name);
    if (userNew != null) {
      _userRepository.updateUser(userNew);
    }
  }
}
