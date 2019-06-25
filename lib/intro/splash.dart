import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:flutter_app/auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:math';

class SpritePainter extends CustomPainter {
  final Animation<double> _animation;

  SpritePainter(this._animation) : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    Color color = new Color.fromRGBO(0, 117, 194, opacity);

    double size = rect.width / 2;
    double area = size * size;
    double radius = sqrt(area * value / 4);

    final Paint paint = new Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = new Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(SpritePainter oldDelegate) {
    return true;
  }
}
class SplashScreen extends StatefulWidget {

  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  AnimationController _controller;

  @override
  Widget build(BuildContext context) {

    

    return new Scaffold(
      body: new CustomPaint(
        painter: new SpritePainter(_controller),

        child: Center(

        child: new SizedBox(
          width: 150.0,
          height: 150.0,
          child: new Column(
            children: <Widget>[
              new Container(
               margin: new EdgeInsets.only(bottom: 10.0,top: 10.0,right: 100.0,left: 100.0),
              )
            ],
          )
        ),

        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _startAnimation,
        child: new Icon(Icons.play_arrow),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.normal,
    );

    new Timer(new Duration(milliseconds: 13000), () {
      checkFirstSeen();
    });
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  void _startAnimation() {
    _controller.stop();
    _controller.reset();
    _controller.repeat(
      period: Duration(seconds: 1),
    );
  }

  Future checkFirstSeen() async {

    ///async method that's why I used await(waiting response or result from source)...
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Home()));
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new IntroScreen()));
    }
  }
}


///home class
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Hello'),
      ),
      body: new Center(
        child: new Text('This is the second page'),
      ),
    );
  }
}

/// welcome-intro class
class IntroScreen extends StatelessWidget {

  static TextStyle style = TextStyle(fontSize: 20.0,);
  //making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
        pageColor: const Color(0xFFFFFFFF),
        bubble: Image.asset('assets/image_01.png'),
        body: Text(
//          'Welcome  to  intro  slider  in  flutter  with  package  intro  views  flutter  latest  update',
          'Welcome  to  Turtle  Haselfree   booking   of   truck   with   awesome   experience ',style: style,
        ),
        title: Text(
          '',
        ),
        textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.green),
        mainImage: Image.asset(
          'assets/image_01.png',
          height: 255.0,
          width: 255.0,
          alignment: Alignment.center,
        )),
    PageViewModel(
      pageColor: const Color(0xFFFFFFFF),
      iconImageAssetPath: 'assets/image_02.png',
      body: Text(
//        'Amazevalley  intoduce  you  with  the  latest  features  coming  in  flutter  with  practical  demos',
        'Turtle  work  for  the  truck solution  which  helps  to  all  the  vendors  to  book  a  truck  on  your  fingers',style: style,
      ),
      title: Text(''),
      mainImage: Image.asset(
        'assets/image_02.png',
        height: 255.0,
        width: 255.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.green),
    ),
    PageViewModel(
      pageColor: const Color(0xFFFFFFFF),
      iconImageAssetPath: 'assets/logo.png',
      body: Text(
//        'Amazevalley  give  you  brief  soluton  about  technology  where  you  fall  in  love',
        'Tutle  is the solution  of  truck  booking  at  your  doorstep  with  cashless  payment  system.',style: style,
      ),
      title: Text(''),
      mainImage: Image.asset(
        'assets/logo.png',
        height: 255.0,
        width: 255.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(fontFamily: 'MyFont', color: Colors.green),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      debugShowCheckedModeBanner: false,
      title: 'IntroViews Flutter', //title of app
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), //ThemeData
      home: Builder(
        builder: (context) => IntroViewsFlutter( pages,
          onTapDoneButton: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ), //MaterialPageRoute
            );
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.greenAccent,
            fontSize: 18.0,
          ),
        ), //IntroViewsFlutter
      ), //Builder
    ); //Material App
  }
}
