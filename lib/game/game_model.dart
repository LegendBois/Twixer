import 'package:Twixer/utils/network_util.dart';

class Game {
  int id;
  String link;
  String imageLink;
  String title;
  //String content;

  Game({
    this.id,
    this.link,
    this.imageLink,
    this.title,
  });

  static List<Game> fetchAll() {
    return [
      Game(
          id: 0,
          link: "https://www.ubisoft.com/en-gb/game/rainbow-six/siege",
          imageLink:
              "https://store.ubi.com/dw/image/v2/ABBS_PRD/on/demandware.static/-/Sites-masterCatalog/default/dwdf41a589/images/large/56c494ad88a7e300458b4d5a.jpg?sw=341&sh=450&sm=fit",
          title: "Tom Clancy's Rainbow Six Siege"),
      Game(
          id: 1,
          link: "https://www.minecraft.net/en-us/",
          imageLink:
              "https://www.minecraft.net/content/dam/minecraft/pdp/Minecraft-xbox-one.jpg",
          title: "Minecraft"),
      Game(
          id: 2,
          link: "https://play.euw.leagueoflegends.com/en_GB",
          imageLink:
              "https://theme.zdassets.com/theme_assets/43400/87a1ef48e43b8cf114017e3ad51b801951b20fcf.jpg",
          title: "League of Legends"),
      Game(
          id: 3,
          link: "https://blog.counter-strike.net/",
          imageLink:
              "https://steamcdn-a.akamaihd.net/steam/apps/730/header.jpg?t=1592263625",
          title: "CSGO"),
    ];
  }
}
