import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

import 'homebody.dart';
import 'homedrawer.dart';
import 'homeappbar.dart';
import 'package:Twixer/news/news_model.dart';
import 'package:Twixer/game/game_model.dart';
import 'package:Twixer/routes.dart';
import 'package:Twixer/style.dart' as style;

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  final news = News.fetchAll();
  final games = Game.fetchAll();

  int _itemCount;
  bool _loop;
  bool _autoplay;
  int _autoplayDelay;
  double _padding;
  bool _outer;
  double _radius;
  double _viewportFraction;
  int _currentIndex;
  int _currentGameIndex;
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
    _currentGameIndex = 0;
    _curve = Curves.ease;
    _scale = 0.95;
    _radius = 10.0;
    _padding = 0.0;
    _loop = true;
    _itemCount = 5;
    _autoplay = true;
    _autoplayDelay = 3000;
    _viewportFraction = 0.88;
    _outer = false;
    _scrollDirection = Axis.horizontal;
    _autoplayDisableOnInteraction = true;
    _animationDuration = Duration(milliseconds: 500);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: ListView(
          padding: EdgeInsets.only(top: 8.0),
          children: <Widget>[
            SizedBox(
              height: 300,
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
              ),
            ),
            SizedBox(height: 32),
          ]..addAll(games.map((game) => _gamesItem(context, game.id)))),
      drawer: HomeDrawer(),
    );
  }

  Widget _gamesItem(BuildContext context, int index) {
    return new GestureDetector(
      onTap: () => _onGameTap(context, index),
      child: Card(
        color: Color.fromARGB(10, 194, 50, 100),
        child: Row(
          children: <Widget>[
            Image.network(
              this.games[index].imageLink,
              fit: BoxFit.fitHeight,
              width: 100,
              height: 150,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    width: 150,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      this.games[index].title,
                      style: style.SubTitleTextGame,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: 150,
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      this.games[index].description,
                      style: style.DescTextGame,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        elevation: 3,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(5.0),
        // ),
      ),
    );
  }

  _onGameTap(BuildContext context, int index) {
    Navigator.pushNamed(context, GameRoute,
        arguments: {"game": this.games[index]});
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
            opacity:
                (_currentIndex == index) ? (_showDescription ? 0.8 : 0.3) : 0.8,
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
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    news[index].imageLink,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
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
                  padding: const EdgeInsets.all(16.0),
                  child: Text(news[index].title,
                      style: Theme.of(context).textTheme.headline6),
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
