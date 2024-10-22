import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_cash_food/firebase_options.dart';
import 'utils/app_colors.dart';
import 'utils/app_strings.dart';
import 'utils/route_generator.dart';
import 'utils/screen_bindings.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.urbanistTextTheme(baseTheme.textTheme),
      scaffoldBackgroundColor: kBackgroundColor,
      colorScheme: ThemeData().colorScheme.copyWith(primary: kBackgroundColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localStorage = GetStorage();
    String? email = localStorage.read('email');
    bool? isTeamJoined = localStorage.read('isTeamJoined');

    String initialRoute;
    if (email == null || email.isEmpty) {
      initialRoute = kSplashScreenRoute;
    } else if (isTeamJoined == false) {
      initialRoute = kCreateTeamRoute;
    } else {
      initialRoute = kNavBarRoute;
    }

    return ScreenUtilInit(
      designSize: const Size(430, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
            theme: _buildTheme(Brightness.light),
            title: kAppName,
            debugShowCheckedModeBanner: false,
            initialBinding: ScreenBindings(),
            initialRoute: initialRoute,
            getPages: RouteGenerator.getPages(),
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                      textScaler: TextScaler.linear(MediaQuery.of(context)
                          .textScaleFactor
                          .clamp(1.0, 1.0))),
                  child: child!);
            });
      },
    );
  }
}
