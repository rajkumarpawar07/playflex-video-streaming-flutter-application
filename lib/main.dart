import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:login_flutter_app/firebase_options.dart';
import 'package:login_flutter_app/src/features/authentication/screens/mainPage/main_page.dart';
import 'package:login_flutter_app/src/features/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:login_flutter_app/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:login_flutter_app/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:login_flutter_app/src/features/core/screens/dashboard/dashboard.dart';
import 'package:login_flutter_app/src/repository/authentication_repository/authentication_repository.dart';
import 'package:login_flutter_app/src/utils/theme/theme.dart';
import 'package:login_flutter_app/utils.dart';

import 'main_page.dart';
import 'models/liked_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // Hive.registerAdapter(MediaAdapter());
  // await Hive.openBox('items');
  // ServiceLocator.init();
  // print("Hive complete");

  await Hive.initFlutter();
  Hive.registerAdapter<LikedModel>(LikedModelAdapter());
  await Hive.openBox<LikedModel>('liked');

  await Firebase.initializeApp(
          options: DefaultFirebaseOptions
              .currentPlatform) //currentPlatform - android , ios, web, etc
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  print("Firebase complete");

  // runApp(
  //   BlocProvider(
  //     create: (context) => sl<WatchlistBloc>(),
  //     child: const MyApp(),
  //   ),
  // );
  runApp(const MyApp());
  print("runApp!");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("Inside the MyApp");
    // return GetMaterialApp(
    //   title: 'flutter Demo',
    //   theme: MyTheme.lighttheme,
    //   darkTheme: MyTheme.darktheme,
    //   themeMode: ThemeMode.system,
    //   debugShowCheckedModeBanner: false,
    //   // defaultTransition: Transition.rightToLeftWithFade,
    //   transitionDuration: const Duration(milliseconds: 500),
    //   home: const Scaffold(
    //     body: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   ),
    // );

    return GetMaterialApp(
      title: 'Movie app',
      theme: MyTheme.lighttheme,
      darkTheme: MyTheme.darktheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const CircularProgressIndicator(),
    );
    // theme: ThemeData(
    //     brightness: Brightness.dark,
    //     fontFamily: 'poppins',
    //     iconTheme: const IconThemeData(color: Colors.white),
    //     textTheme: const TextTheme(
    //         bodyMedium: TextStyle(
    //           color: Colors.white,
    //         ),
    //         bodyLarge: TextStyle(
    //           color: Colors.white,
    //           fontWeight: FontWeight.bold,
    //         ),
    //         titleLarge: TextStyle(
    //             fontSize: 20,
    //             fontWeight: FontWeight.w600,
    //             color: Colors.white)),
    //     scaffoldBackgroundColor: kBackgoundColor,
    //     pageTransitionsTheme: const PageTransitionsTheme(builders: {
    //       TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    //       TargetPlatform.android: ZoomPageTransitionsBuilder()
    //     })),

    // return MaterialApp.router(
    //   debugShowCheckedModeBanner: faldebugShowCheckedModeBanner: false,
    //       home: const Scaffold(
    //         body: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       ),
    //     );se,
    //   title: 'flutter Demo',
    //   // theme: MyTheme.lighttheme,
    //   // darkTheme: MyTheme.darktheme,
    //   // themeMode: ThemeMode.system,
    //   theme: getApplicationTheme(),
    //   routerConfig: AppRouter().router,
    // );
  }
}
