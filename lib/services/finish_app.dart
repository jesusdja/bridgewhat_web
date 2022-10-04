import 'package:bridgewhat_web/services/local_storage.dart';
import 'package:flutter/material.dart';

Future<void> finishApp() async{
  try{
    LocalStorage.prefs.remove('AcademyStatusInitial');
    LocalStorage.prefs.remove('AcademyToken');
    debugPrint('TODO LIMPIO');
  }catch(e){
    debugPrint(e.toString());
  }
}