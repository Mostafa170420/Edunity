import 'package:edunity/feature/auth/data/models/user_type_enum.dart';

class AuthEvent {}

class LoginEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {
  UserTypeEnum userType;
  RegisterEvent({required this.userType});
}
