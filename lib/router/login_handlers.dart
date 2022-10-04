import 'package:bridgewhat_web/ui/view/login/forgot_password.dart';
import 'package:bridgewhat_web/ui/view/login/login_view.dart';
import 'package:bridgewhat_web/ui/view/login/register_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class LoginHandlers {

  static Handler login = Handler(
    handlerFunc: ( context, params ) {
      return const LoginView();
    }
  );

  static Handler register = Handler(
    handlerFunc: ( context, params ) {
      return const RegisterView();
    }
  );

  static Handler forGot = Handler(
    handlerFunc: ( context, params ) {
      return const ForgotPassView();
    }
  );


}

