import 'package:flutter/material.dart';

abstract class AuthenEvent {}

class LoginEvent extends AuthenEvent {
  LoginEvent(this.context);
  final BuildContext context;
}

class InputUserNameEvent extends AuthenEvent {
  InputUserNameEvent({required this.username});
  final String username;
}

class InputPasswordEvent extends AuthenEvent {
  InputPasswordEvent({required this.password});
  final String password;
}

class MaintainLoginEvent extends AuthenEvent {
  MaintainLoginEvent(this.context);
  final BuildContext context;
}

class LogoutEvent extends AuthenEvent {
  LogoutEvent(this.context);
  final BuildContext context;
}
