import 'package:bridgewhat_web/router/dashboard_handlers.dart';
import 'package:bridgewhat_web/router/login_handlers.dart';
import 'package:bridgewhat_web/router/no_page_found_handlers.dart';
import 'package:fluro/fluro.dart';

class Flurorouter {

  static final FluroRouter router = FluroRouter();

  // Dashboard
  static String rootRoute     = '/';
  static String dashboardRoute = '/dashboard';

  static String levers = '/levers';
  static String news = '/news';
  static String log = '/20LOG';
  static String demo    = '/demo';
  static String cartoons    = '/cartoons';
  static String demoDetails    = '/demo/:id';
  static String sendEmail = '/sendEmail';
  static String quiz = '/quiz';

  // Auth Router
  static String loginRoute    = '/auth/login';
  static String registerRoute    = '/auth/register';
  static String forgotPass    = '/auth/forgot-password';


  static void configureRoutes() {
    // Dashboard
    router.define( rootRoute, handler: DashboardHandlers.splash, transitionType: TransitionType.fadeIn );
    router.define( dashboardRoute, handler: DashboardHandlers.dashboard, transitionType: TransitionType.fadeIn );
    router.define( news, handler: DashboardHandlers.dashboard, transitionType: TransitionType.fadeIn );
    router.define( log, handler: DashboardHandlers.dashboard, transitionType: TransitionType.fadeIn );
    router.define( demo, handler: DashboardHandlers.dashboard, transitionType: TransitionType.fadeIn );
    router.define( cartoons, handler: DashboardHandlers.dashboard, transitionType: TransitionType.fadeIn );
    router.define( levers, handler: DashboardHandlers.levers, transitionType: TransitionType.fadeIn );
    router.define( demoDetails, handler: DashboardHandlers.demoDetails, transitionType: TransitionType.fadeIn );
    router.define( sendEmail, handler: DashboardHandlers.sendEmail, transitionType: TransitionType.fadeIn );
    router.define( quiz, handler: DashboardHandlers.quiz, transitionType: TransitionType.fadeIn );

    // Login Routes
    router.define( loginRoute, handler: LoginHandlers.login, transitionType: TransitionType.none );
    router.define( registerRoute, handler: LoginHandlers.register, transitionType: TransitionType.none );
    router.define( forgotPass, handler: LoginHandlers.forGot, transitionType: TransitionType.none );

    // 404
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}

