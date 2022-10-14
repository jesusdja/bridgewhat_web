import 'package:bridgewhat_web/config/academy_colors.dart';
import 'package:bridgewhat_web/config/academy_style.dart';
import 'package:bridgewhat_web/main.dart';
import 'package:bridgewhat_web/ui/view/menu/demo/demo_view.dart';
import 'package:bridgewhat_web/widgets_utils/button_general.dart';
import 'package:bridgewhat_web/widgets_utils/widgets_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoSelected extends StatefulWidget {
  const DemoSelected({Key? key, required this.type}) : super(key: key);
  final int type;
  @override
  State<DemoSelected> createState() => _DemoSelectedState();
}

class _DemoSelectedState extends State<DemoSelected> {

  List<String> title = ['CRYSTAL','SILVER','GOLD','PLATINUM'];
  Map<int,String> priceForType = {
    0 : '1.990€|199€',
    1 : '4.990€|499€',
    2 : '14.990€|',
    3 : '38.990€|',
  };
  int cardSelectedType = 0;

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
          body: Column(
            children: [
              SizedBox(height: sizeH * 0.01,),
              headerContainer(),
              SizedBox(height: sizeH * 0.02,),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    width: sizeW,
                    child: Column(
                      children: [
                        Container(
                          width: sizeW,
                          margin: EdgeInsets.symmetric(horizontal: sizeW * 0.06),
                          child: bannerTitle(type: 3),
                        ),
                        // titleCard(),
                        //title2Card(),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05),
                          child: CardDemo(type: widget.type,isButtonInfo: false),
                        ),
                        // descriptionCard(),
                        // cardPostImg(),
                        selectedAccessPublish(),
                        contentsCardSelected(),
                        // buttonBottom(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerContainer(){
    return Container(
      width: sizeW,
      margin: EdgeInsets.only(left: sizeW * 0.06, right: sizeW * 0.03),
      child: Row(
        children: [
          iconApp(),
          Expanded(child: Container()),
          IconButton(
            icon: Icon(Icons.cancel_outlined,size: sizeH * 0.04,color: AcademyColors.primary),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget iconApp(){

    double size = MediaQuery.of(context).size.width;

    return Container(
      height: 100,
      width: size > 400 ? 200 : (size <= 250 ? 50 : size - 200),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: Image.asset('assets/image/logo_colores_fondo_transparente.png').image,
            fit: BoxFit.fitWidth
        ),
      ),
    );
  }

  Widget titleCard(){
    return InkWell(
      onTap: (){
        //Navigator.push(context,MaterialPageRoute<void>( builder: (context) => DemoSelectedVideo(type: widget.type,)),);
      },
      child: Container(
        width: sizeW,
        margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05, vertical: sizeH * 0.02),
        padding: EdgeInsets.all(sizeH * 0.005),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          border: Border.all(
            width: 2.0,
            color: AcademyColors.colors_95C4E9,
          ),
        ),
        child: Center(
          child: Text('Demo ${title[widget.type]} Bridgewhat',style: AcademyStyles().stylePoppins(
            size: sizeH * 0.025,color: AcademyColors.colors_95C4E9,fontWeight: FontWeight.bold
          )),
        ),
      ),
    );
  }

  Widget title2Card(){
    return Container(
      width: sizeW,
      margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05),
      child: Row(
        children: [
          Expanded(
            child: title2CardText(type: 0),
          ),
          SizedBox(width: sizeW * 0.02),
          Expanded(
            child: title2CardText(type: 1),
          )
        ],
      ),
    );
  }

  Widget title2CardText({required int type}){

    String title = type == 0 ? 'YEARLY' : 'MONTHLY';
    String subTitle = type == 0 ? priceForType[widget.type].toString().split('|')[0] : priceForType[widget.type].toString().split('|')[1];
    TextStyle style = AcademyStyles().styleLato(size: 14,color: Colors.white);

    return subTitle.isEmpty ? Container() : Container(
      padding: EdgeInsets.all(sizeH * 0.015),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: AcademyColors.colors_95C4E9,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title,style: style),
          ),
          Container(
            margin: EdgeInsets.only(right: sizeW * 0.02),
            child: Text(subTitle,style: style),
          ),
        ],
      ),
    );
  }

  Widget descriptionCard(){
    return Container(
      width: sizeW,
      margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05, vertical: sizeH * 0.025),
      child: Text('The Bridgewhat 20 Levers of Growth (20LOG) is a proprietary framework that was developed to create a language of growth between Buyers and Sellers.\nBuyers are the companies that need to grow.\nSellers are the business services companies that may help buyers to grow.\nWhile buyers use the 20LOG to gain perspective on how to grow, sellers are ranged around these 20LOG in the Bridgewhat Platform.\nBut what are these 20LOG and how are they organized?',
      style: AcademyStyles().styleLato(size: 12,color: AcademyColors.colors_787878,heightText: sizeH * 0.0022)),
    );
  }

  Widget cardPostImg(){
    return Container(
      width: sizeW,
      height: sizeH * 0.22,
      margin: EdgeInsets.symmetric(vertical: sizeH * 0.02, horizontal: sizeW * 0.05),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
            image: Image.asset('assets/image/img_example.png').image,
            fit: BoxFit.fill
        ),
      ),
    );
  }

  Widget selectedAccessPublish(){
    return Container(
      width: sizeW,
      margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05, vertical: sizeH * 0.02),
      child: Row(
        children: [
          Expanded(
            child: cardSelectedAccessPublish(type: 0),
          ),
          SizedBox(width: sizeW * 0.03),
          Expanded(
            child: cardSelectedAccessPublish(type: 1),
          ),
        ],
      ),
    );
  }

  Widget cardSelectedAccessPublish({required int type}){

    String title = type == 0 ? 'Access' : 'Create';

    return InkWell(
      onTap: (){
        setState(() {
          cardSelectedType = type;
        });
      },
      child: Container(
        width: sizeW,
        padding: EdgeInsets.all(sizeH * 0.01),
        decoration:  BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: cardSelectedType == type ? AcademyColors.colorsLeversObscure : Colors.white,
          border: Border.all(
            color: AcademyColors.colorsLeversObscure,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: Text(title,
          style: AcademyStyles().styleLato(size: 14,color: cardSelectedType != type ? AcademyColors.colorsLeversObscure : Colors.white,fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget contentsCardSelected(){

    List<Widget> listW = [];
    List<String> listData = cardSelectedType == 0 ? accessTitle[widget.type] :  createTitle[widget.type];
    for (var element in listData) {
      listW.add(contentsCardSelectedContainer(title: element));
    }

    return Container(
      width: sizeW,
      margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05,vertical: sizeH * 0.02),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: sizeW * 0.02,
        runSpacing: sizeH * 0.01,
        children: listW,
      ),
    );

  }

  Widget contentsCardSelectedContainer({required String title}){
    return InkWell(
      child: Container(
        width: sizeW * 0.4,
        height: sizeH * 0.13,
        padding: EdgeInsets.all(sizeH * 0.01),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: AcademyColors.colors_95C4E9
        ),
        child: Center(
          child: Text(title.toUpperCase(),style: AcademyStyles().styleLato(
              color: Colors.white,
              size: sizeH * 0.02,
              fontWeight: FontWeight.bold
          ),),
        ),
      ),
      onTap: (){
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) {
            return infoTitle(title: title);
          },
        );
      },
    );
  }

  Widget infoTitle({required String title}){

    String description = cardSelectedType == 0 ? infoAccessTitle[title]! :  infoCreateTitle[title]!;

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: sizeW * 0.9,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: sizeH * 0.02,vertical: sizeH * 0.025),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: sizeW,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.cancel_outlined, size: sizeH * 0.035, color: Colors.black),
                          onPressed: ()=> Navigator.of(context).pop(),
                        ),
                        Expanded(
                          child: Text(title.toUpperCase(),style: AcademyStyles().stylePoppins(
                            size: sizeH * 0.025,color: Colors.black,
                          )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: sizeH * 0.02),
                  SizedBox(
                    width: sizeW,
                    child: Text(description,textAlign: TextAlign.justify,style: AcademyStyles().stylePoppins(
                        size: sizeH * 0.018
                    )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Map<int,dynamic> accessTitle = {
    0 : ['Advisors','Companies','Posts','Samplings','Protocols','I want to sell','I want yo buy','Campaigns','partnerships',],
    1 : ['Advisors','Companies','Posts','Samplings','Protocols','I want to sell','I want yo buy','Campaigns','partnerships',],
    2 : ['Advisors','Companies','Posts','Samplings','Protocols','I want to sell','I want yo buy','Campaigns','partnerships',],
    3 : ['Advisors','Companies','Posts','Samplings','Protocols','I want to sell','I want yo buy','Campaigns','partnerships',],
  };
  Map<int,dynamic> createTitle = {
    0 : ['posts','Samplings'],
    1 : ['posts','Samplings','Protocols','I want to sell','I want yo buy','Campaigns'],
    2 : ['posts','Samplings','Protocols','I want to sell','I want yo buy','Campaigns','partnerships'],
    3 : ['posts','Samplings','Protocols','I want to sell','I want yo buy','Campaigns','partnerships'],
  };
  Map<String,String> infoAccessTitle = {
    'Advisors' : 'Ad hoc days.\n\nHere is a group of selected advisors willing to share with you their experience and knowledge built throughout their C-Suite level careers. Why increase your risk and waste your resources, when someone can show you the way?',
    'Companies' : 'Here is a group of selected companies that share with you the willingness for ambitious growth. Once you start to explore each of the companies’ cards you can access key metrics that help you to find opportunities to do business. You can click company profile for basics, credentials board for trust, and channel for opportunities. Sellers of services or software linked to the Bridgewhat 20 Levers of Growth will be tagged with the correspondent levers of specialization.',
    'Posts' : 'Here you can learn more on how to grow by accessing content around the Bridgewhat 20 Levers of Growth published by other participants that want to share their experiences and know-how.',
    'Samplings' : 'Here you will get for free products or services from other participants that want you to try them and give feedback on your experience.',
    'Protocols' : 'Here you can access promotions on products and services offered by other Bridgewhat participants.',
    'I want to sell' : 'Here you can look for specific offers published by sellers of services and software linked to the Bridgewhat 20 Levers of Growth that can help you to accelerate your growth.',
    'I want yo buy' : 'As a seller of services and software linked to the Bridgewhat 20 Levers of Growth, here you have several opportunities to do business.',
    'Campaigns' : 'Here you can look for, and take advantage of, campaigns published by all of the Silver, Gold and Platinum Bridgewhat participants.',
    'partnerships' : 'Here you can look for, and take advantage of, partnerships published by all of the Gold and Platinum partnering Bridgewhat participants.',
  };
  Map<String,String> infoCreateTitle = {
    'posts' : 'Multimedia posts are an undisputable way of showing your company’s competences. Organized around the Bridgewhat 20 Levers of Growth, these publications will allow you to position your company as an expert in your correspondent fields of action.',
    'Samplings' : 'There is no better way to create a first-hand customer experience than let your target audience get access to a sample of your products or services for free. Not only you are building brand awareness but also grasping feedback that help you to improve your offer.',
    'Protocols' : 'Start selling in Bridgewhat by offering special conditions to your peer participants. These special conditions can be translated in better prices, better service levels or other features that are capable of hooking new clients.',
    'I want to sell' : 'As a Bridgewhat seller, you can publish as many specific offers as you wish, highlighting your differentiators and why your company is able to deliver a high standard of services/software related to the Bridgewhat 20 Levers of Growth. It is expected that via your, “best in class catalogue”, potential clients will find a good partner to successfully help them on their growth journeys.',
    'I want yo buy' : 'If, after researching among sellers of services/software related to the Bridgewhat 20 Levers of Growth (in general) and their “I want to sell” (in particular), you still haven’t found the best solution to help you to accelerate your company’s growth, as a gold and up participant you can publish a specific need and we guarantee you that we will find at least a suitable seller.',
    'Campaigns' : 'Apart from the Marketplace for services/software organized around the Bridgewhat 20 Levers of Growth, all Gold and Platinum participants can use the platform as a distribution channel, via Campaigns. A campaign must define an advantage that leads to an indisputable business case to the correspondent buyer. Participants can publish as many campaigns as they want.',
    'partnerships' : 'Partnerships allow you to offer your products or services to other participants’ clients, via joint I want to sell, campaigns or protocols. Participants can initiate as many partnerships as they want. Bridgewhat guarantees that, following participants initiative, at least, two partnerships per year will be set among the three parties involved: two channel and/or product partners (among participants) and Bridgewhat.',
  };
}
