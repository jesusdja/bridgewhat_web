import 'package:bridgewhat_web/config/academy_colors.dart';
import 'package:bridgewhat_web/config/academy_style.dart';
import 'package:bridgewhat_web/main.dart';
import 'package:bridgewhat_web/router/router.dart';
import 'package:bridgewhat_web/services/navigation_service.dart';
import 'package:bridgewhat_web/ui/view/menu/demo/widgets/demo_page_more_info.dart';
import 'package:bridgewhat_web/widgets_utils/widgets_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DemoView extends StatefulWidget {
  const DemoView({Key? key}) : super(key: key);

  @override
  State<DemoView> createState() => _DemoViewState();
}

class _DemoViewState extends State<DemoView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              width: sizeW,
              margin: EdgeInsets.symmetric(horizontal: sizeW * 0.06),
              child: bannerTitle(type: 3),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: sizeW,
                  child: Column(
                    children: [
                      SizedBox(height: sizeH * 0.02),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: sizeW * 0.105),
                        width: sizeW,
                        child: Text('To see what are the benefits you can get from each of the packages, please click in Crystal, Silver, Gold and Platinum.',
                            textAlign: TextAlign.left,style: AcademyStyles().stylePoppins(
                                size: sizeH * 0.015
                            )),
                      ),
                      const CardDemo(type: 0),
                      const CardDemo(type: 1),
                      const CardDemo(type: 2),
                      const CardDemo(type: 3),
                    ],
                  ),
                ),
              ),
            )
          ],
        )
    );
  }

}

class CardDemo extends StatefulWidget {
  const CardDemo({Key? key, required this.type, this.isButtonInfo = true}) : super(key: key);
  final int type;
  final bool isButtonInfo;

  @override
  State<CardDemo> createState() => _CardDemoState();
}

class _CardDemoState extends State<CardDemo> {
  late int type;
  late Size size;

  @override
  void initState() {
    super.initState();
    type = widget.type;
  }

  Widget containerBody({required List<Widget> children}){
    return size.width <= 700 ? Column( children: children,) : Row(children: children,);
  }


  @override
  Widget build(BuildContext context) {

    size = MediaQuery.of(context).size;

    String title = 'CRYSTAL';
    List<String> listTitle = ['Registration','View and create posts','Sampling','Reviews','Access to opportunities','Advisor marketplace(Ad hoc days)'];
    Color color = AcademyColors.colors_95C4E9;
    if(type == 1){
      title = 'SILVER';
      color = AcademyColors.colors_85939D;
      listTitle = ['Everything in Crystal +','Credentials board','Protocols','Campaigns','20 LOG marketplace',];
    }
    if(type == 2){
      title = 'GOLD';
      color = AcademyColors.colors_958E6F;
      listTitle = ['Everything in Silver +','20 LOG survey','Partnerships',];
    }
    if(type == 3){
      title = 'PLATINUM';
      color = AcademyColors.colorsB2BEC6;
      listTitle = ['Everything in Gold +','Advisory Services(12 days package)',];
    }


    List<Widget> listW = [];
    for (var element in listTitle) {
      listW.add(
        Container(
          width: sizeW,
          margin: EdgeInsets.only(bottom: sizeH * 0.01),
          child: Row(
            children: [
              Icon(Icons.circle,color: Colors.black,size: sizeH * 0.01,),
              SizedBox(width: sizeW * 0.02),
              Expanded(
                child: Text(element,style: AcademyStyles().styleLato(size: 12,color: Colors.black,),),
              ),
            ],
          ),
        ),
      );
    }

    if(widget.isButtonInfo){
      listW.add(
        SizedBox(
          width: sizeW,
          child: containerBody(
            children: [
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: color,
                  ),
                  child: Text('+ INFO',style: AcademyStyles().styleLato(size: 12,color: Colors.white,),),
                ),
                onTap: (){
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) {
                      return DemoPageMoreInfo(type: type,);
                    },
                  );
                },
              ),
              SizedBox(width: sizeW * 0.02,),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    color: color,
                  ),
                  child: Text('GET STARTED',style: AcademyStyles().styleLato(size: 12,color: Colors.white,),),
                ),
                onTap: () async{
                  DateTime dateTime = DateTime.now();
                  String _url = 'https://calendly.com/mafalda-sottomayor/contact-bridgewhat?month=${dateTime.year}-${dateTime.month.toString().padLeft(2,'0')}';
                  if (!await launchUrl(Uri.parse(_url))) {
                    throw 'Could not launch $_url';
                  }
                },
              )
            ],
          ),
        ),
      );
    }

    return InkWell(
      onTap: (){
        if(widget.isButtonInfo){
          //Navigator.push(context,MaterialPageRoute<void>( builder: (context) => DemoSelected(type: type,)),);
          NavigationService.navigateTo(Flurorouter.demoDetails.replaceAll(':id', type.toString()));
        }
      },
      child: Container(
        width: sizeW * 0.5,
        margin: EdgeInsets.only(top: sizeH * 0.02),
        padding: EdgeInsets.symmetric(vertical: sizeH * 0.015),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: AcademyColors.colorsE8E8E8,
        ),
        child: Row(
          children: [
            Container(
              width: sizeW * 0.1,
              height: sizeH * 0.05,
              margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: color,
              ),
              child: Center(
                child: Text(title,style: AcademyStyles().stylePoppins(
                    size: sizeH * 0.02,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                )),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: listW,
              ),
            )
          ],
        ),
      ),
    );
  }
}
