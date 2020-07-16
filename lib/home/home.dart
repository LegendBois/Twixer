import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

import 'homebody.dart';
import 'homedrawer.dart';
import 'homeappbar.dart';
import 'package:Twixer/news/news_model.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  final news = News.fetchAll();

  int _itemCount;
  bool _loop;
  bool _autoplay;
  int _autoplayDelay;
  double _padding;
  bool _outer;
  double _radius;
  double _viewportFraction;
  int _currentIndex;
  double _scale;
  Axis _scrollDirection;
  Curve _curve;
  double _fade;
  bool _autoplayDisableOnInteraction;
  bool _showDescription = true;
  Duration _animationDuration;

  @override
  void initState() {
    _showDescription = false;
    _fade = 1.0;
    _currentIndex = 0;
    _curve = Curves.ease;
    _scale = 0.9;
    _radius = 10.0;
    _padding = 0.0;
    _loop = true;
    _itemCount = 5;
    _autoplay = false;
    _autoplayDelay = 3000;
    _viewportFraction = 0.8;
    _outer = false;
    _scrollDirection = Axis.horizontal;
    _autoplayDisableOnInteraction = false;
    _animationDuration = Duration(milliseconds: 500);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Home loaded");

    return Scaffold(
      appBar: HomeAppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Column(
          children: <Widget>[
            Expanded(
                child: new Swiper(
              itemCount: _itemCount,
              itemHeight: 200.0,
              itemBuilder: _newsItem,
              fade: _fade,
              index: _currentIndex,
              onIndexChanged: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              curve: _curve,
              scale: _scale,
              controller: new SwiperController(),
              outer: _outer,
              viewportFraction: _viewportFraction,
              autoplayDelay: _autoplayDelay,
              loop: _loop,
              autoplay: _autoplay,
              scrollDirection: _scrollDirection,
              indicatorLayout: PageIndicatorLayout.COLOR,
              autoplayDisableOnInteraction: _autoplayDisableOnInteraction,
            )),
            Expanded(
              flex: 2,
              child: Container(),
            ),
          ],
        ),
      ),
      drawer: HomeDrawer(),
    );
  }

  Widget _newsItem(BuildContext context, int index) {
    return new ClipRRect(
      borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            this.news[index].imageLink,
            fit: BoxFit.cover,
          ),
          AnimatedOpacity(
            opacity: (_currentIndex == index) ? 0.3 : 0.8,
            duration: _animationDuration,
            child: Container(
              color: Colors.black,
            ),
          ),
          IgnorePointer(
            ignoring: _showDescription,
            child: AnimatedAlign(
              alignment:
                  !_showDescription ? Alignment.bottomLeft : Alignment.topLeft,
              duration: _animationDuration,
              child: AnimatedOpacity(
                opacity: _showDescription ? 1.0 : 0.0,
                duration: _animationDuration,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(news[index].imageLink,
                      style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ),
          IgnorePointer(
            ignoring: !_showDescription,
            child: AnimatedAlign(
              alignment:
                  !_showDescription ? Alignment.bottomLeft : Alignment.topLeft,
              duration: Duration(milliseconds: 400),
              child: AnimatedOpacity(
                opacity: !_showDescription ? 1.0 : 0.0,
                duration: _animationDuration,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text(news[index].title, style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showDescription = !_showDescription;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
