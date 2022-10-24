import 'package:bridgewhat_web/config/academy_colors.dart';
import 'package:bridgewhat_web/config/academy_style.dart';
import 'package:bridgewhat_web/main.dart';
import 'package:bridgewhat_web/providers/videos_provider.dart';
import 'package:bridgewhat_web/router/router.dart';
import 'package:bridgewhat_web/services/navigation_service.dart';
import 'package:bridgewhat_web/ui/view/menu/videos/widgets/tabbar_widget.dart';
import 'package:bridgewhat_web/widgets_utils/circular_progress_colors.dart';
import 'package:bridgewhat_web/widgets_utils/widgets_shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class VideosView extends StatefulWidget {
  const VideosView({Key? key}) : super(key: key);

  @override
  State<VideosView> createState() => _VideosViewState();
}

class _VideosViewState extends State<VideosView> {

  late VideosProvider videosProvider;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500)).then((value) =>
        videosProvider.getVideos());
  }

  @override
  Widget build(BuildContext context) {

    videosProvider = Provider.of<VideosProvider>(context);

    return GestureDetector(
      onTap: (){
      },
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          body: Column(
            children: [
              //headerShared(context: context,scaffoldKey: scaffoldKey),
              Expanded(
                child: SizedBox(
                  width: sizeW,
                  //margin: EdgeInsets.symmetric(horizontal: sizeW * 0.06),
                  child: Column(
                    children: [
                      Container(
                        width: sizeW,
                        margin: EdgeInsets.symmetric(horizontal: sizeW * 0.06),
                        child: bannerTitle(type: 1),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(height: sizeH * 0.04),
                              cardContainer(),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Container(
                width: sizeW,
                height: sizeH * 0.06,
                color: AcademyColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: 'Please take ',
                            style: AcademyStyles().stylePoppins(size: 12,color: Colors.white ),
                            children: [
                              WidgetSpan(
                                child: InkWell(
                                  onTap: (){
                                    //Navigator.push(context,MaterialPageRoute<void>( builder: (context) => const QuizPage()),);
                                    NavigationService.replaceTo(Flurorouter.quiz);
                                  },
                                  child: Container(
                                    width: sizeW * 0.12,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(
                                        width: 1.0,
                                        color: AcademyColors.primary,
                                      ),
                                    ),
                                    child: Center(
                                        child: Text('QUIZ',style: AcademyStyles().stylePoppins(size: 12,color: AcademyColors.primary,
                                            fontWeight: FontWeight.bold),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: ' know more about the ',
                                style: AcademyStyles().stylePoppins(size: 12,color: Colors.white),
                              ),
                              WidgetSpan(
                                child: InkWell(
                                  onTap: (){
                                    NavigationService.replaceTo(Flurorouter.levers);
                                  },
                                  child: Container(
                                    width: sizeW * 0.15,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(
                                        width: 1.0,
                                        color: AcademyColors.primary,
                                      ),
                                    ),
                                    child: Center(
                                        child: Text('20 LOG',style: AcademyStyles().stylePoppins(size: 12,color: AcademyColors.primary,
                                            fontWeight: FontWeight.bold),
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Tabbar(),
            ],
          )
      ),
    );
  }

  Widget cardContainer(){

    List<Widget> listW = [];
    for (var element in videosProvider.listVideos) {
      listW.add(CardPostContainer(videos: element));
    }

    return SizedBox(
      width: sizeW,
      child: Column(
        children: listW,
      ),
    );
  }
}

class CardPostContainer extends StatefulWidget {
  const CardPostContainer({Key? key, required this.videos}) : super(key: key);

  final Map<String,dynamic> videos;

  @override
  State<CardPostContainer> createState() => _CardPostContainerState();
}

class _CardPostContainerState extends State<CardPostContainer> {

  Map<String,dynamic> video = {};
  late VideosProvider videosProvider;
  List<String> listTitleLikes = ['','Like','Love','Wow','Clap','Curious','Insightful'];
  List<String> listTitleShared = ['','Linkedin','Instagram','Twitter','Facebook'];
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    video = widget.videos;
    _controller = VideoPlayerController.network(video['url'])
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    videosProvider = Provider.of<VideosProvider>(context);

    return SizedBox(
      width: 500,
      child: Column(
        children: [
          cardVideo(),

          SizedBox(
            width: sizeW,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(!_controller.value.isInitialized)...[
                  circularProgressColors(),
                ]else...[
                  IconButton(onPressed: (){
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  }, icon: Icon(_controller.value.isPlaying ? Icons.pause_circle_outline : Icons.play_circle_outline),
                      color: AcademyColors.primary,iconSize: 30),
                ],
              ],
            ),
          ),
          cardBottom(),
          cardSubVideos(),
          SizedBox(height: sizeH * 0.04,)
        ],
      ),
    );
  }

  Widget cardVideo(){
    return Container(
      width: 500,
      height: sizeH * 0.25,
      margin: EdgeInsets.only(bottom: sizeH * 0.01),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: (){
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: SizedBox(
              width: sizeW,
              height: sizeH * 0.25,
              child: Center(
                child: _controller.value.isInitialized
                    ? VideoPlayer(_controller) :
                circularProgressColors(widthContainer1: sizeW, widthContainer2: sizeW * 0.06,colorCircular: AcademyColors.primary),
              ),
            ),
          ),
          if(!_controller.value.isInitialized || !_controller.value.isPlaying)...[
            Align(
              alignment: Alignment.center,
              child: Container(
                width: sizeW,
                height: sizeH * 0.25,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset('assets/image/capture_video_${video['id']}.png').image,
                        fit: BoxFit.fitWidth
                    )
                ),
              ),
            ),
          ],
          // if(_controller.value.isInitialized && !_controller.value.isPlaying)...[
          //   Align(
          //     alignment: Alignment.center,
          //     child: InkWell(
          //       onTap: (){
          //         videosProvider.viewContainerLikePost(idPost: video['id']);
          //       },
          //       child: InkWell(
          //         child: Icon(Icons.play_circle_outline,color: AcademyColors.primary,size: sizeH * 0.08),
          //         onTap: (){
          //           _controller.play();
          //           setState(() {});
          //         },
          //       ),
          //     ),
          //   ),
          // ],
        ],
      ),
    );
  }

  Widget cardBottom(){

    String title = video['title'];
    String description = video['description'];

    TextStyle style = AcademyStyles().styleLato(size: sizeH * 0.022,color: Colors.black);
    TextStyle style2 = AcademyStyles().styleLato(size: sizeH * 0.02,color: AcademyColors.colors_787878);

    bool isMoreActive = videosProvider.openDescription[video['id']!] ?? false;

    return Container(
      width: sizeW,
      margin: EdgeInsets.only(bottom: sizeH * 0.02,left: sizeW * 0.06),
      child: Column(
        children: [
          InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: (){
              if(!isMoreActive){
                videosProvider.viewContainerMoreDescriptionPost(idPost: video['id']);
              }
            },
            child: SizedBox(
              width: sizeW,
              child: RichText(
                text: TextSpan(
                  text: title, // _snapshot.data['username']
                  style: style,
                  children: <TextSpan>[
                    if(!isMoreActive)...[
                      TextSpan(
                        text: ' . . . More',
                        style: AcademyStyles().styleLato(size: 12,color: AcademyColors.primary),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
          if(isMoreActive)...[
            SizedBox(height: sizeW * 0.02,),
            SizedBox(
              width: sizeW,
              child: Text(description,style: style2,),
            ),
          ]
        ],
      ),
    );
  }

  Widget cardSubVideos(){
    return Container(
      width: sizeW,
      margin: EdgeInsets.symmetric(horizontal: sizeW * 0.05),
      child: Row(
        children: [
          Expanded(child: containerCardSubVideos(type: videosProvider.mapSubVideos[video['id']]!.keys.elementAt(0))),
          SizedBox(width: sizeW * 0.02,),
          Expanded(child: containerCardSubVideos(type: videosProvider.mapSubVideos[video['id']]!.keys.elementAt(1))),
          SizedBox(width: sizeW * 0.02,),
          Expanded(child: containerCardSubVideos(type: videosProvider.mapSubVideos[video['id']]!.keys.elementAt(2))),
          SizedBox(width: sizeW * 0.02,),
          Expanded(child: containerCardSubVideos(type: videosProvider.mapSubVideos[video['id']]!.keys.elementAt(3))),
        ],
      ),
    );
  }

  Widget containerCardSubVideos({required int type}){
    TextStyle style = AcademyStyles().styleLato(size: sizeH * 0.018,color: Colors.black);

    return Card(
      elevation: 5,
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 1.0,
              color: AcademyColors.primary,
            ),
          ),
          child: Center(
            child: Text(videosProvider.titleButtonVideo[type]!,style: style),
          ),
        ),
        onTap: () async {
          String _url = 'https://bridgewhat.ole.agency/videos/LOG_$type.mp4';
          if (!await launchUrl(Uri.parse(_url))) {
          throw 'Could not launch $_url';
          }
        },
      ),
    );
  }
}

