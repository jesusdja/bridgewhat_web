import 'package:bridgewhat_web/providers/auth_provider.dart';
import 'package:bridgewhat_web/providers/cartoons_provider.dart';
import 'package:bridgewhat_web/providers/menu_provider.dart';
import 'package:bridgewhat_web/providers/post_provider.dart';
import 'package:bridgewhat_web/providers/quiz_provider.dart';
import 'package:bridgewhat_web/providers/videos_provider.dart';
import 'package:bridgewhat_web/router/router.dart';
import 'package:bridgewhat_web/services/local_storage.dart';
import 'package:bridgewhat_web/services/navigation_service.dart';
import 'package:bridgewhat_web/ui/layou/home_layout.dart';
import 'package:bridgewhat_web/ui/layou/login_layout.dart';
import 'package:bridgewhat_web/ui/layou/splash_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

double sizeH = 0;
double sizeW = 0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  await LocalStorage.configurePrefs();
  Flurorouter.configureRoutes();

  int isLogin = LocalStorage.prefs.getInt('AcademyStatusInitial') ?? 0;
  if(isLogin == 1){ LocalStorage.prefs.setInt('AcademyStatusInitial',0); }

  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false,create: ( _ ) => AuthProvider()),
        ChangeNotifierProvider(lazy: false,create: ( _ ) => MenuProvider()),
        ChangeNotifierProvider(lazy: false,create: ( _ ) => PostProvider()),
        ChangeNotifierProvider(lazy: false,create: ( _ ) => VideosProvider()),
        ChangeNotifierProvider(lazy: false,create: ( _ ) => QuizProvider()),
        ChangeNotifierProvider(lazy: false,create: ( _ ) => CartoonsProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bridgewhat',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      builder: ( context2 , child ){

        final authProvider = Provider.of<AuthProvider>(context);

        sizeH = MediaQuery.of(context2).size.height;
        sizeW = MediaQuery.of(context2).size.width;

        if ( authProvider.authStatus == AuthStatus.login ) {
          return LoginLayout(child: child!);
        }

        if ( authProvider.authStatus == AuthStatus.home ) {
          return HomeLayout(child: child!);
        }

        return const SplashLayout();
      },
      theme: ThemeData.light().copyWith(
          scrollbarTheme: const ScrollbarThemeData().copyWith(
              thumbColor: MaterialStateProperty.all(
                  Colors.grey.withOpacity(0.5)
              )
          )
      ),
    );
  }
}
