import 'package:bridgewhat_web/config/academy_colors.dart';
import 'package:bridgewhat_web/config/academy_style.dart';
import 'package:flutter/material.dart';


Widget bannerTitle({required int type, String? descrip, String? titleSt}){


  Widget avatar = CircleAvatar(
    backgroundColor: AcademyColors.primary,
    radius: 20,
    child: Center(
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset('assets/image/Exclude_$type.png').image,
              fit: BoxFit.fitWidth
          ),
        ),
      ),
    ),
  );

  String title = 'NEWS';
  double marginL = 20; //sizeW * 0.03;
  String description = descrip ?? 'View Bridgewhat participant´s posts';
  Color colorSuvTitle = AcademyColors.primary;

  if(type == 1){title = '20 LOG'; description = 'Learn about the Bridgewhat 20 Levers of Growth';}
  if(type == 2){title = 'CARTOONS'; description = 'Have fun with Bridgewhat Cartoons';}
  if(type == 3){title = 'DEMO';description = 'Bridgewhat features at a glance';}
  if(type == 4){title = 'QUIZ LEVELS OF GROWTH';}
  if(type == 5){description = 'Advisors';}
  if(type == 6){
    title = 'LEVERS';
    description = '20 LEVERS OF GROWTH (20 LOG)';
    avatar = Container(); marginL = 0;
    colorSuvTitle = AcademyColors.colorsLeversObscure;
  }

  title = titleSt ?? title;

  return SizedBox(
    width: 300,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        avatar,
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: marginL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: AcademyStyles().stylePoppins(fontWeight: FontWeight.bold,color: AcademyColors.colors_787878,size: 18)),
                Text(description,style: AcademyStyles().styleLato(size: 14,color: colorSuvTitle)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}