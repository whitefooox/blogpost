import 'package:blogpost/module/user/domain/entity/user.dart';

abstract class IUserService {
  Future<void> deleteUser();
  Future<User> getUser();
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
}