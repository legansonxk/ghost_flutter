import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home/home_model.dart';
import '../tag/tag_model.dart';
import '../author/author_model.dart';
import '../tabbar/tabbar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _StateSplashScreen createState() => _StateSplashScreen();
}

class _StateSplashScreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2300), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.forward().whenComplete(() => Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(microseconds: 200),
            pageBuilder: (BuildContext context, Animation<double> _,
                Animation<double> __) {
              return TabScreen();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var tween = Tween<double>(begin: 0.0, end: 1.0);

              return FadeTransition(
                opacity: tween.animate(animation),
                child: child,
              );
            },
          ),
        ));
    Future.delayed(Duration.zero, () {
      Provider.of<HomeModel>(context, listen: false).loadMorePosts();
      Provider.of<TagModel>(context, listen: false).loadMoreTags();
      Provider.of<AuthorModel>(context, listen: false).loadMoreAuthors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: screenSize.width,
            height: screenSize.height,
            child: Center(
              child: Image.asset(
                'assets/images/splash.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  color: Colors.white.withOpacity(animation.value),
                  child: Container(),
                );
              })
        ],
      ),
    );
  }
}
