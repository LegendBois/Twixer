import 'package:Twixer/home/homeappbar.dart';
import 'package:flutter/material.dart';

import 'package:Twixer/common/image_banner.dart';
import 'package:Twixer/common/text_section.dart';
import 'package:Twixer/game/game_model.dart';
import 'package:Twixer/common/social_links.dart';

class GameDetail extends StatelessWidget {
  final Game _game;

  GameDetail(this._game);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: ListView(
        children: [
          ImageBanner(_game.imageLink),
          TextSection(_game.title, _game.description),
          SizedBox(
            height: 50,
          ),
          SocialLinks(),
        ],
      ),
    );
  }
}
