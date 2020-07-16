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
              itemCount: 5,
              itemHeight: 200.0,
              itemBuilder: _newsItem,
              viewportFraction: 0.8,
              scale: 0.9,
              indicatorLayout: PageIndicatorLayout.COLOR,
              pagination: new SwiperPagination(
                  builder: const DotSwiperPaginationBuilder(
                      size: 10.0, activeSize: 20.0, space: 10.0)),
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
      child: Image.network(
        this.news[index].imageLink,
        fit: BoxFit.cover,
      ),
    );
    ;
  }
}
