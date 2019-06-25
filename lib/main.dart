import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'widgetsAuth/FormCard.dart';
//import 'widgetsAuth/SocialIcons.dart';
//import 'CustomIcons.dart';
import 'package:flutter_app/intro/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Demo',
      home: new SplashScreen(),
    );
  }
}
