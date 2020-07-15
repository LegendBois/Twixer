import 'package:flutter/material.dart';

import 'homebody.dart';
import 'homedrawer.dart';
import 'homeappbar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Home loaded");
    return Scaffold(
      appBar: HomeAppBar(),
      body: HomeBody(),
      drawer: HomeDrawer(),
    );
  }
}
