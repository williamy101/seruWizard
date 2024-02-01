import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:seru_wizard/config/app_color.dart';
import 'package:seru_wizard/config/app_route.dart';
import 'package:seru_wizard/pages/wizard1.dart';
import 'package:seru_wizard/pages/wizard2.dart';
import 'package:seru_wizard/pages/wizard3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColor.primary,
        textTheme: GoogleFonts.workSansTextTheme(),
        scaffoldBackgroundColor: AppColor.bgScaffold,
        colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
          secondary: AppColor.secondary,
        ),
      ),
      home: WizardOne(),
      routes: {
        AppRoute.wizard1: (context) => WizardOne(),
        AppRoute.wizard2: (context) => const WizardTwo(),
        AppRoute.wizard3: (context) => const WizardThree(),
      },
    );
  }
}
