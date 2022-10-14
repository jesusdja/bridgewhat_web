import 'package:bridgewhat_web/config/academy_colors.dart';
import 'package:bridgewhat_web/config/academy_style.dart';
import 'package:bridgewhat_web/main.dart';
import 'package:bridgewhat_web/providers/post_provider.dart';
import 'package:bridgewhat_web/widgets_utils/widgets_shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostView extends StatefulWidget {
  const PostView({Key? key}) : super(key: key);

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {

  late PostProvider postProvider;
  final ScrollController scrollController = ScrollController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initialData();
    scrollController.addListener((){
      getDataPost();
    });
  }

  Future getDataPost() async {
    if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
      if(!postProvider.isLoadData){
        bool result = await postProvider.getPosts(isInit: false);
        if(result){
          if(scrollController.position.pixels >= (scrollController.position.maxScrollExtent - 300)){
            scrollController.animateTo(
                scrollController.position.pixels + 120,
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn
            );
          }
        }
      }
    }
  }

  initialData(){
    Future.delayed(const Duration(milliseconds: 100)).then((value){
      if(postProvider.dataAll.isEmpty){
        postProvider.getPosts(isInit: true);
      }
      postProvider.viewContainerLikePost(idPost: 0);
      postProvider.viewContainerSharedPost(idPost: 0);
    });
  }

  @override
  Widget build(BuildContext context) {

    postProvider = Provider.of<PostProvider>(context);

    return GestureDetector(
      onTap: (){
        postProvider.viewContainerLikePost(idPost: 0);
        postProvider.viewContainerSharedPost(idPost: 0);
      },
      child: Container(
        width: sizeW,
        margin: EdgeInsets.symmetric(horizontal: sizeW * 0.06),
        child: Column(
          children: [
            SizedBox(
              width: sizeW,
              child: bannerTitle(type: 0),
            ),
            SizedBox(height: sizeH * 0.02),
            Expanded(
              child: cardContainer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget cardContainer(){
    List<Widget> listW = [];
    for (var element in postProvider.listPost) {
      listW.add(CardPostContainer(post: element));
    }

    return Stack(
      children: [
        SizedBox(
          width: sizeW,
          child: ListView.builder(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            itemCount: listW.length,
            itemBuilder: (context,index){
              return listW[index];
            },
          ),
        ),
        if(postProvider.isLoadData)...[
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 20),
              height: 50,width: 50,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                shape: BoxShape.circle
              ),
              child: const CircularProgressIndicator(color: AcademyColors.primary),
            ),
          ),
        ]
      ],
    );
  }
}

class CardPostContainer extends StatefulWidget {
  const CardPostContainer({Key? key, required this.post}) : super(key: key);

  final Map<String,dynamic> post;

  @override
  State<CardPostContainer> createState() => _CardPostContainerState();
}

class _CardPostContainerState extends State<CardPostContainer> {

  Map<String,dynamic> post = {};
  late PostProvider postProvider;
  List<String> listTitleLikes = ['','Like','Love','Wow','Clap','Curious','Insightful'];
  List<String> listTitleShared = ['','Linkedin','Instagram','Twitter','Facebook'];

  @override
  void initState() {
    super.initState();
    post = widget.post;
  }

  @override
  Widget build(BuildContext context) {

    postProvider = Provider.of<PostProvider>(context);

    bool postSelectLike = postProvider.postLikes[post['id']] ?? false;
    bool postSelectShared = postProvider.postShared[post['id']] ?? false;

    if(post['header_image'] == null) return Container();

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 500,
          child: Column(
            children: [
              cardPostTop(),
              cardPostImg(),
              cardBottom(),
            ],
          ),
        ),
        if(postSelectLike)...[
          Container(
            margin: EdgeInsets.only(top: sizeH * 0.3,right: sizeW * 0.05,left: sizeW * 0.25),
            child: selectLike(),
          )
        ],
        if(postSelectShared)...[
          Container(
            margin: EdgeInsets.only(top: sizeH * 0.3),
            child: Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                selectShared()
              ],
            ),
          )
        ],

      ],
    );
  }

  Widget cardPostTop(){

    String nameUser = post['company_name'] ?? '';
    DateTime dateDT = DateTime.parse(post['created_at']);
    String dateSt = '${dateDT.day.toString().padLeft(2,'0')}/${dateDT.month.toString().padLeft(2,'0')}/${dateDT.year}';

    Widget urlLogo = Container(
      height: 50,width: 80,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset('assets/image/img_acenture.png').image,
              fit: BoxFit.fitWidth
          )
      ),
    );
    if(post.containsKey('company_logo') && post['company_logo'] != null && post['company_logo'].toString().isNotEmpty) {
      urlLogo = Container(
        height: 50,width: 80,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.network(post['company_logo']).image,
                fit: BoxFit.fitWidth
            )
        ),
      );
    }

    return Container(
      width: sizeW,
      margin: EdgeInsets.only(bottom: sizeH * 0.00),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          urlLogo,
          SizedBox(width: sizeW * 0.02,),
          Expanded(child: Text(nameUser,style: AcademyStyles().styleLato(
              size: 20,
              color: AcademyColors.colors_787878
          )),),
          SizedBox(width: sizeW * 0.02,),
          Text(dateSt,style: AcademyStyles().styleLato(
              size: 16,
              color: AcademyColors.colors_737373
          )),
        ],
      ),
    );
  }

  Widget cardPostImg(){
    return Container(
      width: sizeW,
      height: sizeH * 0.3,
      margin: EdgeInsets.only(bottom: sizeH * 0.02),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        image: DecorationImage(
            image: Image.network(post['header_image']).image,
            fit: BoxFit.cover
        ),
      ),
      // child: Stack(
      //   children: [
      //     Align(
      //       alignment: Alignment.bottomRight,
      //       child: InkWell(
      //         onTap: (){
      //           postProvider.viewContainerLikePost(idPost: post['id']);
      //         },
      //         child: Container(
      //           height: sizeH * 0.03,
      //           width: sizeH * 0.03,
      //           margin: EdgeInsets.only(bottom: sizeH * 0.015,right: 60),
      //           decoration: BoxDecoration(
      //               image: DecorationImage(
      //                   image: Image.asset('assets/image/button_like.png').image,
      //                   fit: BoxFit.fitWidth
      //               )
      //           ),
      //         ),
      //       ),
      //     ),
      //     Align(
      //       alignment: Alignment.bottomRight,
      //       child: InkWell(
      //         onTap: (){
      //           postProvider.viewContainerSharedPost(idPost: post['id']);
      //         },
      //         child: Container(
      //           margin: EdgeInsets.only(bottom: sizeH * 0.015,right: 20),
      //           height: sizeH * 0.03,
      //           width: sizeH * 0.03,
      //           decoration: BoxDecoration(
      //               image: DecorationImage(
      //                   image: Image.asset('assets/image/button_shared.png').image,
      //                   fit: BoxFit.fitWidth
      //               )
      //           ),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }

  Widget cardBottom(){

    String title = post['title'] ?? '';
    String likeSt = '0  likes';// '${numberFormat(double.parse('${post['like']}')).split(',')[0]} likes';
    String sharedSt ='0  times shared'; // '${numberFormat(double.parse('${post['shared']}')).split(',')[0]} times shared';

    TextStyle style = AcademyStyles().styleLato(size: 12,color: Colors.black);
    TextStyle style2 = AcademyStyles().styleLato(size: 10,color: Colors.white);

    return Container(
      width: sizeW,
      margin: EdgeInsets.only(bottom: sizeH * 0.02),
      child: Column(
        children: [
          SizedBox(
            width: sizeW,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(title,style: style),
                ),
                SizedBox(width: sizeW * 0.1,),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: sizeW * 0.03,vertical: sizeH * 0.005),
                    decoration: const BoxDecoration(
                      color: AcademyColors.colors_787878,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: FittedBox(
                      fit:BoxFit.contain,
                      child: Row(
                        children: [
                          Text(likeSt,style: style2),
                          Container(width: 10),
                          Text(sharedSt,style: style2),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: sizeW * 0.1,),
          textDescription(),
        ],
      ),
    );
  }

  Widget selectLike(){

    List<Widget> listW = [];
    for(int x = 1; x < 7; x++){
      listW.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: sizeW * 0.02),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: sizeH * 0.032,
                width: sizeH * 0.032,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset('assets/image/like$x.png').image,
                        fit: BoxFit.fitHeight
                    )
                ),
              ),
              // Text(listTitleLikes[x],style: AcademyStyles().styleLato(size: 12,color: AcademyColors.primary),)
            ],
          ),
        ),
      );
    }


    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          width: 1.0,
          color: AcademyColors.primary,
        ),
      ),
      child: FittedBox(
        fit:BoxFit.contain,
        child: Row(
          children: listW,
        ),
      ),
    );
  }

  Widget selectShared(){

    List<Widget> listW = [];
    for(int x = 1; x < 5; x++){
      listW.add(
        Container(
          width: sizeW * 0.2,
          margin: EdgeInsets.symmetric(horizontal: sizeW * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: sizeH * 0.032,
                width: sizeH * 0.032,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset('assets/image/shared$x.png').image,
                        fit: BoxFit.fitWidth
                    )
                ),
              ),
              SizedBox(width: sizeW * 0.02,),
              Expanded(
                child: Text(listTitleShared[x],style: AcademyStyles().styleLato(size: 10,color: AcademyColors.primary)),
              ),
            ],
          ),
        ),
      );
      if(x < 4) {
        listW.add(
          Container(
            margin: EdgeInsets.symmetric(vertical: sizeH * 0.01),
            height: 0.5,
            width: sizeW * 0.2,
            color: AcademyColors.colorsC4C4C4,
          ),
        );
      }
    }


    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(0),
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(0),
          bottomLeft: Radius.circular(10),
        ),
        border: Border.all(
          width: 0.0,
          color: AcademyColors.primary,
        ),
      ),
      child: FittedBox(
        fit:BoxFit.contain,
        child: Column(
          children: listW,
        ),
      ),
    );
  }

  Widget textDescription(){

    String description = post['description'] ?? '';

    Widget textMore = Container();

    if(description.length > 150){
      bool isMoreActive = postProvider.postViewMoreDescription[post['id']!]!;
      if(isMoreActive){
        textMore = Text(description,style: AcademyStyles().styleLato(size: 12,color: AcademyColors.colors_787878),);
      }else{
        textMore =  InkWell(
          onTap: (){
            postProvider.viewContainerMoreDescriptionPost(idPost: post['id']);
          },
          child: SizedBox(
            child: RichText(
              text: TextSpan(
                text: description.substring(0,150), // _snapshot.data['username']
                style: AcademyStyles().styleLato(size: 12,color: AcademyColors.colors_787878),
                children: <TextSpan>[
                  TextSpan(
                    text: '. . .  More',
                    style: AcademyStyles().styleLato(size: 12,color: AcademyColors.primary),
                  )
                ],
              ),
            ),
          ),
        );
      }
    }else{
      textMore = Text(description,style: AcademyStyles().styleLato(size: 12,color: AcademyColors.colors_787878),
      textAlign: TextAlign.left,);
    }




    return Container(
      width: sizeW,
      margin: EdgeInsets.only(top: sizeH * 0.01,bottom: sizeH * 0.035),
      child: textMore,
    );
  }
}

