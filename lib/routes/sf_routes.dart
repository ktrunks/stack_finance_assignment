import 'package:fluro/fluro.dart';

import 'sf_route_handlers.dart';

///
class SFRoutes {
  ///
  static FluroRouter router;

  /// root end point
  static const String root = "/";

  /// home screen
  static const String home = "/home";

  /// sign screen
  static const String signIn = "/sign";

  /// webview screen
  static const String webView = "/web_view";

  static const String addNote = "/add_note";

  static const String changePassword = "/change_password ";

  /// configuring routes
  static void configureRoutes(FluroRouter router) {
    router.define(root,
        handler: rootHandler, transitionType: TransitionType.inFromRight);
    router.define(signIn,
        handler: singInHandler, transitionType: TransitionType.inFromRight);
    router.define(home,
        handler: homeHandler, transitionType: TransitionType.inFromRight);
    router.define(webView,
        handler: webViewHandler, transitionType: TransitionType.inFromRight);
    router.define(addNote,
        handler: noteScreenHandler, transitionType: TransitionType.inFromRight);
    router.define(changePassword,
        handler: changePasswordScreenHandler, transitionType: TransitionType.inFromRight);
  }
}
