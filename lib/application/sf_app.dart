import 'package:fluro/fluro.dart' as route;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_finance_assignment/application/sf_application_provider.dart';
import 'package:stack_finance_assignment/routes/sf_routes.dart';
import 'package:stack_finance_assignment/util/color/colors.dart';

/// Application class
class SFApp extends StatefulWidget {
  /// shared preference object
  // final SharedPreferences sharedPreferences;

  /// constructor with shared preference object
  SFApp();

  @override
  _SFAppState createState() => _SFAppState();
}

class _SFAppState extends State<SFApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SFApplicationProvider>(create: (_) => SFApplicationProvider()),
      ],
      child: MaterialApp(
        initialRoute: SFRoutes.root,
        debugShowCheckedModeBanner: false,
        title: 'SF Assignment',
        onGenerateRoute: SFRoutes.router.generator,
        theme: ThemeData(
          primaryColor: primaryColor,
          backgroundColor: primaryColor,
          buttonColor: primaryColor,
          accentColor: primaryColor,
          primarySwatch: secondaryPrimarySwatchColor,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final router = route.FluroRouter();
    SFRoutes.router = router;
    SFRoutes.configureRoutes(router);
  }

  ///
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
