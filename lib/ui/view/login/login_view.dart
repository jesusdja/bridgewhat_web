import 'package:bridgewhat_web/config/academy_colors.dart';
import 'package:bridgewhat_web/config/academy_style.dart';
import 'package:bridgewhat_web/main.dart';
import 'package:bridgewhat_web/router/router.dart';
import 'package:bridgewhat_web/services/http_connection.dart';
import 'package:bridgewhat_web/services/local_storage.dart';
import 'package:bridgewhat_web/services/navigation_service.dart';
import 'package:bridgewhat_web/widgets_utils/button_general.dart';
import 'package:bridgewhat_web/widgets_utils/circular_progress_colors.dart';
import 'package:bridgewhat_web/widgets_utils/textfield_general.dart';
import 'package:bridgewhat_web/widgets_utils/toast_widget.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  bool obscurePass = true;
  bool checkRemember = false;
  bool loadData = false;
  // TextEditingController controllerEmail = TextEditingController(text: 'academyuser6@yopmail.com');
  // TextEditingController controllerPass = TextEditingController(text: '123456Aa');
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextField = AcademyStyles().styleLato(size: sizeH * 0.02,color: AcademyColors.primaryGreyApp,fontWeight: FontWeight.bold);
    TextStyle styleButtonText = AcademyStyles().stylePoppins(size: sizeH * 0.02,color: Colors.white,fontWeight: FontWeight.bold);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: sizeH * 0.15,),
          iconApp(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
            width: 200,
            child: TextFieldGeneral(
              textEditingController: controllerEmail,
              radius: 5,
              borderColor: AcademyColors.primaryGreyApp,
              sizeBorder: 1.5,
              hintText: 'E-mail',
              labelStyle: styleTextField,
              textInputType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(height: sizeH * 0.025,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
            width: 200,
            child: TextFieldGeneral(
              textEditingController: controllerPass,
              radius: 5,
              borderColor: AcademyColors.primaryGreyApp,
              sizeBorder: 1.5,
              hintText: 'Password',
              labelStyle: styleTextField,
              textInputType: TextInputType.visiblePassword,
              obscure: obscurePass,
              suffixIcon: InkWell(
                onTap: () => setState(() { obscurePass = !obscurePass; }),
                child: Icon(obscurePass ? Icons.remove_red_eye_outlined : Icons.remove_red_eye),
              ),
            ),
          ),
          SizedBox(height: sizeH * 0.025,),
          InkWell(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
              width: 200,
              child: Text('Forgot your password?',
                  style: AcademyStyles().styleLato(
                      color: AcademyColors.primary,size: sizeH * 0.02
                  ),textAlign: TextAlign.left),
            ),
            onTap: (){
              NavigationService.navigateTo(Flurorouter.forgotPass.replaceAll(':email', controllerEmail.text));
            },
          ),
          rememberPass(),
          SizedBox(height: sizeH * 0.025,),

          Container(
            margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
            width: 200,
            child: loadData ? Center(
              child: circularProgressColors(widthContainer1: sizeW,widthContainer2: sizeH * 0.03,colorCircular: AcademyColors.primary),
            ) :
            ButtonGeneral(
              title: 'Continue',
              width: sizeW,
              height: sizeH * 0.07,
              backgroundColor: AcademyColors.primary,
              textStyle: styleButtonText,
              radius: 5,
              onPressed: ()=> loginOnTap(),
            ),
          ),
          SizedBox(height: sizeH * 0.03,),
          goToRegister(),
        ],
      ),
    );
  }

  Widget iconApp(){
    return Container(
      height: sizeH * 0.3,
      width: sizeH * 0.3,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset('assets/image/icon_app.png').image,
              fit: BoxFit.fitWidth
          )
      ),
    );
  }

  Widget rememberPass(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
      width: 210,
      child: Row(
        children: [
          Checkbox(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            value: checkRemember,
            onChanged: (value) => setState(() { checkRemember = value!; }),
            checkColor: Colors.white,
            activeColor: AcademyColors.primary,
            side: MaterialStateBorderSide.resolveWith(
                  (states) => const BorderSide(width: 2.0, color: AcademyColors.primary),
            ),
          ),
          Expanded(
            child: Text('remember password',
              style: AcademyStyles().styleLato(
                  color: AcademyColors.primaryGreyApp,
                  size: sizeH * 0.02
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget goToRegister(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sizeW * 0.1),
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text('You don´t have an account?',
              style: AcademyStyles().styleLato(
                  color: AcademyColors.primaryGreyApp,
                  size: sizeH * 0.02
              ),
            ),
          ),
          InkWell(
            child: Text(' Sign up',
              style: AcademyStyles().styleLato(
                  color: AcademyColors.primary,
                  size: sizeH * 0.02
              ),
            ),
            onTap: (){
              // Navigator.pushReplacement(context, MaterialPageRoute(builder:
              //     (BuildContext context) => const RegisterPage()));
              LocalStorage.prefs.setInt('AcademyStatusInitial',1);
              NavigationService.replaceTo(Flurorouter.registerRoute);
            },
          ),
        ],
      ),
    );
  }

  Future loginOnTap() async{
    loadData = true;
    setState(() {});

    String errorText = '';
    if(errorText.isEmpty && !validateEmailAddress(email: controllerEmail.text)['valid']){
      errorText = validateEmailAddress(email: controllerEmail.text)['sms'];
    }
    if(errorText.isEmpty && controllerPass.text.isEmpty){
      errorText = 'Contraseña no puede estar vacia.';
    }
    if(errorText.isEmpty && controllerPass.text.isEmpty){
      errorText = 'Contraseña no puede estar vacia.';
    }
    if(errorText.isEmpty){
      Map<String,dynamic> body = {
        'email' : controllerEmail.text,
        'password' : controllerPass.text,
      };
      if(await HttpConnection().login(body: body)){
        if(checkRemember){
          LocalStorage.prefs.setInt('AcademyStatusInitial',2);
        }
        NavigationService.replaceTo(Flurorouter.dashboardRoute);
      }
    }else{
      showAlert(text: errorText,isSuccess: false);
    }

    loadData = false;
    setState(() {});
  }
}
