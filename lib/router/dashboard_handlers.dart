import 'package:bridgewhat_web/ui/layou/splash_layout.dart';
import 'package:bridgewhat_web/ui/view/home/home_view.dart';
import 'package:bridgewhat_web/ui/view/home/send_email_view.dart';
import 'package:bridgewhat_web/ui/view/menu/demo/widgets/demo_selected.dart';
import 'package:bridgewhat_web/ui/view/menu/levers/levers_page.dart';
import 'package:bridgewhat_web/ui/view/menu/post/post_view.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';


class DashboardHandlers {

  static Handler dashboard = Handler(
      handlerFunc: ( context, params ) {
        return const HomeView();
      }
  );

  static Handler splash = Handler(
      handlerFunc: ( context, params ) {
        return const Scaffold();
      }
  );

  static Handler levers = Handler(
      handlerFunc: ( context, params ) {
        return const LeversPage();
      }
  );

  static Handler demoDetails = Handler(
      handlerFunc: ( context, params ) {
        return DemoSelected(type: int.parse(params['id']![0].toString()));
      }
  );

  static Handler sendEmail = Handler(
      handlerFunc: ( context, params ) {
        return const SendEmailView();
      }
  );


}

