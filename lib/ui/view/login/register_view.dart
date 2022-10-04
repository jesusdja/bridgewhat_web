import 'package:bridgewhat_web/config/academy_colors.dart';
import 'package:bridgewhat_web/config/academy_style.dart';
import 'package:bridgewhat_web/main.dart';
import 'package:bridgewhat_web/router/router.dart';
import 'package:bridgewhat_web/services/http_connection.dart';
import 'package:bridgewhat_web/services/local_storage.dart';
import 'package:bridgewhat_web/services/navigation_service.dart';
import 'package:bridgewhat_web/widgets_utils/button_general.dart';
import 'package:bridgewhat_web/widgets_utils/circular_progress_colors.dart';
import 'package:bridgewhat_web/widgets_utils/dropdown_button_generic.dart';
import 'package:bridgewhat_web/widgets_utils/textfield_general.dart';
import 'package:bridgewhat_web/widgets_utils/toast_widget.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  bool obscurePass = true;
  bool checkPrivacy = false;
  bool checkSendInfo = false;
  bool loadSaveData = false;
  bool emailSend = false;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  TextEditingController controllerCompanyName = TextEditingController();

  List<String> items = ['job function', 'items 1', 'items 2', 'items 3'];
  String itemSelect = 'job function';
  late TextStyle styleTextField;
  late TextStyle styleButtonText;

  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    styleTextField = AcademyStyles().styleLato(size: sizeH * 0.02,color: AcademyColors.primaryGreyApp,fontWeight: FontWeight.bold);
    styleButtonText = AcademyStyles().stylePoppins(size: sizeH * 0.02,color: Colors.white,fontWeight: FontWeight.bold);

    return !emailSend ? body1() : body2();
  }

  Widget body1(){
    return Column(
      children: [
        SizedBox(height: sizeH * 0.02,),
        iconApp(),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: globalKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
                    width: 200,
                    child: TextFieldGeneral(
                      textEditingController: controllerName,
                      initialValue: null,
                      radius: 5,
                      borderColor: AcademyColors.primaryGreyApp,
                      sizeBorder: 1.5,
                      hintText: 'Name *',
                      labelStyle: styleTextField,
                      textInputType: TextInputType.name,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'required field';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
                    width: 200,
                    child: TextFieldGeneral(
                      textEditingController: controllerLastName,
                      initialValue: null,
                      radius: 5,
                      borderColor: AcademyColors.primaryGreyApp,
                      sizeBorder: 1.5,
                      hintText: 'Last name *',
                      labelStyle: styleTextField,
                      textInputType: TextInputType.name,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'required field';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
                    width: 200,
                    child: TextFieldGeneral(
                      textEditingController: controllerEmail,
                      initialValue: null,
                      radius: 5,
                      borderColor: AcademyColors.primaryGreyApp,
                      sizeBorder: 1.5,
                      hintText: 'E-mail *',
                      labelStyle: styleTextField,
                      textInputType: TextInputType.emailAddress,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'required field';
                        }
                        if(!validateEmailAddress(email: value, )['valid']){
                          return 'Email no valid';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
                    width: 200,
                    child: TextFieldGeneral(
                      textEditingController: controllerPass,
                      initialValue: null,
                      radius: 5,
                      borderColor: AcademyColors.primaryGreyApp,
                      sizeBorder: 1.5,
                      hintText: 'Password *',
                      labelStyle: styleTextField,
                      textInputType: TextInputType.visiblePassword,
                      obscure: obscurePass,
                      suffixIcon: IconButton(
                        icon: Icon(obscurePass ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,size: sizeH * 0.03,color: AcademyColors.primary),
                        onPressed: (){ setState(() { obscurePass = !obscurePass; }); },
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'required field';
                        }
                        // if(!validateEmailAddress(email: value, )['valid']){
                        //   return 'Email no valid';
                        // }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
                    width: 200,
                    child: TextFieldGeneral(
                      textEditingController: controllerCompanyName,
                      initialValue: null,
                      radius: 5,
                      borderColor: AcademyColors.primaryGreyApp,
                      sizeBorder: 1.5,
                      hintText: 'Company name',
                      labelStyle: styleTextField,
                      textInputType: TextInputType.name,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'required field';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 5,),
                  goToRegister(),
                  const SizedBox(height: 10,),
                  privacyCheck(),
                  receiveInformationCheck(),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
          width: 200,
          child: loadSaveData ?
          SizedBox(
            width: sizeW,
            child: Center(
              child: circularProgressColors(widthContainer1: sizeW,widthContainer2: sizeH * 0.03,colorCircular: AcademyColors.primary),
            ),
          )
              :
          ButtonGeneral(
            title: 'Continue',
            width: sizeW,
            height: sizeH * 0.07,
            backgroundColor: AcademyColors.primary,
            textStyle: styleButtonText,
            radius: 5,
            onPressed: () async {

              loadSaveData = true;
              setState(() {});

              if(globalKey.currentState!.validate()){
                if(checkPrivacy){

                  Map<String,dynamic> body = {
                    'name' : controllerName.text,
                    'password' : controllerPass.text,
                    'lastname' : controllerLastName.text,
                    'email' : controllerEmail.text,
                    'company' : controllerCompanyName.text,
                    'jobfunction' : 'no/Job',
                  };

                  if(await HttpConnection().register(body: body)){
                    setState(() {
                      emailSend = true;
                    });
                  }
                }else{
                  showAlert(text: 'Check use and privacy policy',isSuccess: false);
                }
              }else{
                showAlert(text: 'No registre',isSuccess: false);
              }

              loadSaveData = false;
              setState(() {});
            },
          ),
        ),
        SizedBox(height: sizeH * 0.03,),
      ],
    );
  }

  Widget body2(){
    return Column(
      children: [
        SizedBox(height: sizeH * 0.4,),
        Container(
          width: 200,
          margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05),
          child: Text('Successful registration',
              style: AcademyStyles().styleLato(
                  color: AcademyColors.primaryGreyApp,
                  size: sizeH * 0.025
              ),
              textAlign: TextAlign.center
          ),
        ),
        SizedBox(height: sizeH * 0.01,),
        Container(
          width: 200,
          margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05),
          child: Text(controllerEmail.text,
              style: AcademyStyles().styleLato(
                  color: AcademyColors.primary,
                  size: sizeH * 0.025
              ),
              textAlign: TextAlign.center
          ),
        ),
        SizedBox(height: sizeH * 0.01,),
        Container(
          width: 400,
          margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05),
          child: Text('with a verification link, open it to verify the account and log in again',
              style: AcademyStyles().styleLato(
                  color: AcademyColors.primaryGreyApp,
                  size: sizeH * 0.025
              ),
              textAlign: TextAlign.center
          ),
        ),
        Expanded(child: Container()),
        ButtonGeneral(
          title: 'Continue',
          margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
          width: sizeW,
          height: sizeH * 0.07,
          backgroundColor: AcademyColors.primary,
          textStyle: styleButtonText,
          radius: 5,
          onPressed: () async {
            LocalStorage.prefs.setInt('AcademyStatusInitial',0);
            NavigationService.replaceTo(Flurorouter.loginRoute);
          },
        ),
        SizedBox(height: sizeH * 0.03,),
      ],
    );
  }

  Widget iconApp(){
    return Container(
      height: 100,
      width: 200,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset('assets/image/logo_colores_fondo_transparente.png').image,
              fit: BoxFit.fitWidth
          )
      ),
    );
  }

  Widget privacyCheck(){
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: sizeW * 0.06),
      child: Row(
        children: [
          Checkbox(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            value: checkPrivacy,
            onChanged: (value) => setState(() { checkPrivacy = value!; }),
            checkColor: Colors.white,
            activeColor: AcademyColors.primary,
            side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 2.0, color: AcademyColors.primary),
            ),
          ),
          Expanded(
            child: Text('I agree to the terms of use and privacy policy',
                style: AcademyStyles().styleLato(
                    color: AcademyColors.primaryGreyApp,
                    size: sizeH * 0.0175
                ),
                textAlign: TextAlign.left
            ),
          ),
        ],
      ),
    );
  }

  Widget receiveInformationCheck(){
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: sizeW * 0.06),
      child: Row(
        children: [
          Checkbox(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            value: checkSendInfo,
            onChanged: (value) => setState(() { checkSendInfo = value!; }),
            checkColor: Colors.white,
            activeColor: AcademyColors.primary,
            side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 2.0, color: AcademyColors.primary),
            ),
          ),
          Expanded(
            child: Text('I do not want to receive information from Bridgewhat',
                style: AcademyStyles().styleLato(
                    color: AcademyColors.primaryGreyApp,
                    size: sizeH * 0.0175
                ),
                textAlign: TextAlign.left
            ),
          ),
        ],
      ),
    );
  }

  Widget goToRegister(){
    return InkWell(
      child: Container(
        width: 200,
        margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
        child: Text('I already have an account',
          style: AcademyStyles().styleLato(color: AcademyColors.primary,size: sizeH * 0.02,textDecoration: TextDecoration.underline,fontWeight: FontWeight.bold),
          textAlign: TextAlign.left),
      ),
      onTap: (){
        LocalStorage.prefs.setInt('AcademyStatusInitial',0);
        NavigationService.replaceTo(Flurorouter.loginRoute);
      },
    );
  }
}