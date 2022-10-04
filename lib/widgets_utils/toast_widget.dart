import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showAlert({required String text,Color color = Colors.green,int sec = 3, String gradient = '#000000, #000000', bool isSuccess = true}){

  if(gradient == '#000000, #000000'){
    gradient = isSuccess ? '#0db50f, #0db50f' : '#ED1C24, #ED1C24';
  }

  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: sec,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
      webPosition: 'center',
      webShowClose: true,
      webBgColor: "linear-gradient(to right, $gradient)"
  );
}