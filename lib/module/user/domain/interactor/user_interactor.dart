import 'package:blogpost/module/user/domain/dependency/i_user_service.dart';
import 'package:blogpost/module/user/domain/entity/user.dart';

class UserInteractor {

  final IUserService _userService;

  UserInteractor(this._userService);

  Future<void> deleteAccount() async {
    await _userService.deleteUser();
  }

  Future<User> getUser() async {
    return await _userService.getUser();
  }

  Future<void> updateUser(User user) async {
    try {
      return await _userService.updateUser(user);
    } catch (e) {
      rethrow;
    }
  }
}