import 'package:bridgewhat_web/router/login_handlers.dart';
import 'package:bridgewhat_web/router/router.dart';
import 'package:bridgewhat_web/services/local_storage.dart';
import 'package:bridgewhat_web/services/navigation_service.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

enum AuthStatus {splash,login,home,}

class AuthProvider extends ChangeNotifier {

  AuthStatus authStatus = AuthStatus.splash;

  AuthProvider() {
    isAuthenticated();
  }

  Future isAuthenticated() async {
    int isLogin = LocalStorage.prefs.getInt('AcademyStatusInitial') ?? 0;


    try{
      if(isLogin == 0){
        authStatus = AuthStatus.login;
      }
      if(isLogin == 1){
        authStatus = AuthStatus.login;
      }
      if(isLogin == 2){
        authStatus = AuthStatus.home;
      }

      notifyListeners();
    }catch(e){
      debugPrint('isLogin 1: ${e.toString()}');
    }

    await Future.delayed(const Duration(seconds: 1));

    try{

      if(isLogin == 0){
        NavigationService.replaceTo(Flurorouter.loginRoute);
      }
      if(isLogin == 1){
        NavigationService.replaceTo(Flurorouter.registerRoute);
      }
      if(isLogin == 2){
        NavigationService.replaceTo(Flurorouter.dashboardRoute);
      }

      notifyListeners();
    }catch(e){
      debugPrint('isLogin : ${e.toString()}');
    }
  }
}