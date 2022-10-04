import 'package:bridgewhat_web/config/academy_colors.dart';
import 'package:bridgewhat_web/config/academy_style.dart';
import 'package:bridgewhat_web/main.dart';
import 'package:bridgewhat_web/router/router.dart';
import 'package:bridgewhat_web/services/navigation_service.dart';
import 'package:bridgewhat_web/widgets_utils/button_general.dart';
import 'package:bridgewhat_web/widgets_utils/circular_progress_colors.dart';
import 'package:bridgewhat_web/widgets_utils/textfield_general.dart';
import 'package:bridgewhat_web/widgets_utils/toast_widget.dart';
import 'package:flutter/material.dart';

class SendEmailView extends StatefulWidget {
  const SendEmailView({Key? key}) : super(key: key);
  @override
  State<SendEmailView> createState() => _SendEmailViewState();
}

class _SendEmailViewState extends State<SendEmailView> {

  int selectedTypePlans = 4;
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSubject = TextEditingController();
  bool loadSignOut = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: GestureDetector(
        onTap: (){},
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: sizeH * 0.01,),
                headerContainer(),
                SizedBox(height: sizeH * 0.02,),
                containerBody()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerContainer(){
    return Container(
      width: sizeW,
      margin: EdgeInsets.only(left: sizeW * 0.1, right: sizeW * 0.1),
      child: Row(
        children: [
          iconApp(),
          Expanded(child: Container()),
          IconButton(
            icon: Icon(Icons.cancel_outlined,size: sizeH * 0.04,color: AcademyColors.primary),
            onPressed: (){
              NavigationService.replaceTo(Flurorouter.dashboardRoute);
            },
          ),
        ],
      ),
    );
  }

  Widget iconApp(){

    double size = MediaQuery.of(context).size.width;

    return FittedBox(
      fit: BoxFit.fitWidth,
      child: SizedBox(
        height: 100,
        width: size > 400 ? 200 : (size <= 250 ? 50 : size - 200),
        child: Center(
          child: Image.asset('assets/image/logo_colores_fondo_transparente.png',fit: BoxFit.fitWidth),
        ),
      ),
    );
  }

  Widget containerBody(){

    TextStyle style = AcademyStyles().styleLato(size: 16,color: AcademyColors.primary,fontWeight: FontWeight.bold);

    return Container(
      margin: EdgeInsets.all(sizeH * 0.03),
      padding: EdgeInsets.all(sizeH * 0.02),
      width: 500,
      decoration: const BoxDecoration(
        color: AcademyColors.colorsE1E1E,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          SizedBox(height: sizeH * 0.04),
          SizedBox(
            width: sizeW,
            child: Text('Send mail to',style: style,textAlign: TextAlign.left,),
          ),
          SizedBox(height: sizeH * 0.02),
          SizedBox(
            width: sizeW,
            child: TextFieldGeneral(
              hintText: 'bridgewhat@bridgewhat.com',
              textEditingController: controllerEmail,
              initialValue: null,
              textInputType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(height: sizeH * 0.02),
          SizedBox(
            width: sizeW,
            child: Text('Email subject here',style: style,textAlign: TextAlign.left,),
          ),
          SizedBox(height: sizeH * 0.02),
          SizedBox(
            width: sizeW,
            child: TextFieldGeneral(
              hintText: '',
              textEditingController: controllerSubject,
              initialValue: null,
              textInputType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(height: sizeH * 0.02),
          SizedBox(
            width: sizeW,
            child: Text('Coments or questions',style: style,textAlign: TextAlign.left,),
          ),
          SizedBox(height: sizeH * 0.02),
          SizedBox(
            width: sizeW,
            child: TextFieldGeneral(
              maxLines: 5,
              padding: EdgeInsets.symmetric(vertical: sizeH * 0.01),
            ),
          ),
          SizedBox(height: sizeH * 0.02),
          loadSignOut ?
          Container(
            padding: EdgeInsets.symmetric(vertical: sizeH * 0.01),
            child: Center(
              child: circularProgressColors(),
            ),
          ) :
          ButtonGeneral(
            title: 'Send email',
            backgroundColor: AcademyColors.primary,
            textStyle: AcademyStyles().stylePoppins(size: 16,color: Colors.white),
            width: sizeW,
            height: sizeH * 0.05,
            radius: 5,
            onPressed: ()  async {
              loadSignOut = true;
              setState(() {});
              showAlert(text: 'sent successfully');
              await Future.delayed(const Duration(seconds: 2));
              loadSignOut = false;
              setState(() {});

              Navigator.of(context).pop();
            },
          ),
          SizedBox(height: sizeH * 0.02),
        ],
      ),
    );
  }

  Widget containerBodyRow1({required int type}){

    String title = 'Crystal';
    if(type == 1){ title = 'Silver'; }
    if(type == 2){ title = 'Gold'; }
    if(type == 3){ title = 'Platinium'; }

    return InkWell(
      onTap: (){
        selectedTypePlans = type;
        setState(() {});
      },
      child: Container(
        width: sizeW,
        decoration:  BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: selectedTypePlans == type ? AcademyColors.primary : Colors.white,
        ),
        padding: EdgeInsets.all(sizeH * 0.02),
        child: Center(
          child: Text(title,style: AcademyStyles().stylePoppins(size: 12, color: selectedTypePlans == type ? Colors.white : Colors.black)),
        ),
      ),
    );
  }

  Future dialogSendResquest() async{

    TextStyle style1 = AcademyStyles().stylePoppins(size: 14, color: AcademyColors.colors_787878);
    TextStyle style2 = AcademyStyles().stylePoppins(size: 14, color: AcademyColors.primary);

    await showDialog(
        context: context,
        builder: ( context ) {
          return SimpleDialog(
            children: [
              InkWell(
                onTap: (){
                  Navigator.of(context).pop(true);
                },
                child: Container(
                  width: sizeW,
                  margin: EdgeInsets.only(right: sizeW * 0.05),
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.cancel_outlined,color: AcademyColors.primary,size: sizeH * 0.03),
                ),
              ),
              Container(
                width: sizeW,
                margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05),
                child: Text('Your request have been send to',style: style1,textAlign: TextAlign.center),
              ),
              Container(
                width: sizeW,
                margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05),
                child: Text(controllerEmail.text,style: style2,textAlign: TextAlign.center),
              ),
              Container(
                width: sizeW,
                margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05),
                child: Text('we are going to contact you soon through your email',style: style1,textAlign: TextAlign.center),
              ),
            ],
          );
        }
    );
    Navigator.of(context).pop(true);
    Navigator.of(context).pop(true);
  }
}
