import 'package:bridgewhat_web/config/academy_colors.dart';
import 'package:bridgewhat_web/config/academy_style.dart';
import 'package:bridgewhat_web/main.dart';
import 'package:bridgewhat_web/providers/menu_provider.dart';
import 'package:bridgewhat_web/providers/post_provider.dart';
import 'package:bridgewhat_web/router/router.dart';
import 'package:bridgewhat_web/services/finish_app.dart';
import 'package:bridgewhat_web/services/local_storage.dart';
import 'package:bridgewhat_web/services/navigation_service.dart';
import 'package:bridgewhat_web/ui/view/menu/cartoons/cartoons_view.dart';
import 'package:bridgewhat_web/ui/view/menu/demo/demo_view.dart';
import 'package:bridgewhat_web/ui/view/menu/post/post_view.dart';
import 'package:bridgewhat_web/ui/view/menu/videos/videos_view.dart';
import 'package:bridgewhat_web/widgets_utils/circular_progress_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomePageState();
}


class _HomePageState extends State<HomeView> {

  late MenuProvider menuProvider;
  bool loadSignOut = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AcademyColors.primary,
    ));
  }

  Future<bool> exit() async {

    if(menuProvider.status != MenuStatus.home){
      menuProvider.changeMenu(MenuStatus.home);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {

    menuProvider = Provider.of<MenuProvider>(context);

    Widget childBody = optionMenu();
    if(menuProvider.status == MenuStatus.news){ childBody = const PostView(); }
    if(menuProvider.status == MenuStatus.log){ childBody = const VideosView(); }
    if(menuProvider.status == MenuStatus.cartoons){ childBody = const CartoonsView(); }
    if(menuProvider.status == MenuStatus.demo){ childBody = const DemoView(); }

    return WillPopScope(
      onWillPop: exit,
      child: SafeArea(
        child: GestureDetector(
          onTap: (){
            Provider.of<PostProvider>(context).viewContainerLikePost(idPost: 0);
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            endDrawer: appDrawer(),
            body: Column(
              children: [
                SizedBox(height: sizeH * 0.01,),
                headerContainer(),
                SizedBox(height: sizeH * 0.01,),
                Expanded(
                  child: childBody,
                ),
                SizedBox(height: sizeH * 0.01,),
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
      margin: EdgeInsets.only(left: sizeW * 0.08, right: sizeW * 0.06),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          menuProvider.status != MenuStatus.home ? SizedBox(
            width: sizeW * 0.07,
            child:  InkWell(
              child: Icon(Icons.arrow_back_ios,size: sizeH * 0.035,color: AcademyColors.primary),
              onTap: (){
                menuProvider.changeMenu(MenuStatus.home);
                NavigationService.replaceTo(Flurorouter.dashboardRoute);
              },
            ) ,
          ): Container(),
          iconApp(),
          Expanded(child: Container()),
           InkWell(
            child: const SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child:  Icon(Icons.email,size: 25,color: AcademyColors.primary),
              ),
            ),
            onTap: (){
              NavigationService.replaceTo(Flurorouter.sendEmail);
              // Navigator.push(context,MaterialPageRoute<void>(
              //     builder: (context) => const SendEmail()),);
            },
          ),
          InkWell(
            child: const SizedBox(
              width: 30,
              height: 30,
              child: Center(
                child:  Icon(Icons.menu,size: 25,color: AcademyColors.primary),
              ),
            ),
            onTap: (){
              scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
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
        ),
      ),
    );
  }

  Widget appDrawer(){

    Widget divide = const Divider();

    return Container(
      width: sizeW * 0.6,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: sizeH * 0.02,),
          Container(
            height: sizeH * 0.2,
            width: sizeH * 0.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset('assets/image/icon_app.png').image,
                  fit: BoxFit.fitWidth
              ),
            ),
          ),
          Expanded(child: Container()),
          titleDrawer(type: 1),
          divide,
          titleDrawer(type: 2),
          loadSignOut ?
          Container(
            padding: EdgeInsets.symmetric(vertical: sizeH * 0.06),
            child: Center(
              child: circularProgressColors(),
            ),
          ) : titleDrawer(type: 0),
          divide,
          SizedBox(height: sizeH * 0.02,),
        ],
      ),
    );
  }

  Widget titleDrawer({required int type}){
    String title = 'SignOut';
    if(type == 1){title = '20 Levers of growth (20 LOG)'; }
    if(type == 2){title = 'Settings'; }

    return InkWell(
      onTap: (){
        if(type == 0){ signOut(); }
        if(type == 1){
          // Navigator.of(context).pop();
          // Navigator.push(context,MaterialPageRoute<void>(
          //     builder: (context) => const LeversPage()),);
          NavigationService.replaceTo(Flurorouter.levers);

        }
      },
      child: Container(
        width: sizeW,
        margin: EdgeInsets.only(left: sizeW * 0.03,bottom: sizeH * 0.01, top: sizeH * 0.01),
        child: Text(title,textAlign: TextAlign.left,
            style: AcademyStyles().stylePoppins(size: sizeH * 0.018,color: AcademyColors.primary,fontWeight: FontWeight.bold)),
      ),
    );
  }

  Future signOut() async{
    loadSignOut = true;
    setState(() {});

    await finishApp();

    LocalStorage.prefs.setInt('AcademyStatusInitial',0);
    NavigationService.replaceTo(Flurorouter.loginRoute);

    // Navigator.pushReplacement(context, MaterialPageRoute(builder:
    //     (BuildContext context) => const AppState()));

    loadSignOut = false;
    setState(() {});
  }

  Widget optionMenu(){

    return SizedBox(
      width: sizeW,
      child: Column(
        children: [
          Expanded(
            child: cardMenu(type: 0),
          ),
          Expanded(
            child: cardMenu(type: 1),
          ),
          Expanded(
            child: cardMenu(type: 2),
          ),
          Expanded(
            child: cardMenu(type: 3),
          ),
        ],
      ),
    );
  }

  Widget cardMenu({required int type}){
    String title = 'NEWS';
    String description = 'View Bridgewhat\nparticipant´s posts';
    if(type == 1){title = '20 LOG'; description = 'Learn about the Bridgewhat\n20 Levers of Growth';}
    if(type == 2){title = 'CARTOONS';description = 'Have fun with\nBridgewhat Cartoons';}
    if(type == 3){title = 'DEMO';description = 'Bridgewhat features\nat a glance';}


    return InkWell(
      onTap: (){
        if(type == 0){ menuProvider.changeMenu(MenuStatus.news); NavigationService.replaceTo(Flurorouter.news);}
        if(type == 1){ menuProvider.changeMenu(MenuStatus.log); NavigationService.replaceTo(Flurorouter.log);}
        if(type == 2){ menuProvider.changeMenu(MenuStatus.cartoons); NavigationService.replaceTo(Flurorouter.cartoons);}
        if(type == 3){ menuProvider.changeMenu(MenuStatus.demo); NavigationService.replaceTo(Flurorouter.demo);}
      },
      child: Container(
        width: 500,
        margin: EdgeInsets.only(left: sizeW * 0.07,right: sizeW * 0.07,bottom: sizeH * 0.02),
        //padding: EdgeInsets.symmetric(vertical: sizeH * 0.035),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: AcademyColors.primary
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05),
              child: Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset('assets/image/Exclude_$type.png').image,
                        fit: BoxFit.fitWidth
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: sizeW * 0.02),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title,textAlign: TextAlign.center,
                        style: AcademyStyles().stylePoppins(size: sizeH * 0.022,color: Colors.white,fontWeight: FontWeight.bold)),
                    FittedBox(
                      fit:BoxFit.contain,
                      child: Text(description,textAlign: TextAlign.center,
                          style: AcademyStyles().stylePoppins(size: sizeH * 0.016,color: Colors.white)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
