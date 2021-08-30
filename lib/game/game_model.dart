import 'package:Twixer/utils/network_util.dart';

class Game {
  int id;
  String link;
  String imageLink;
  String title;
  String description;

  Game({
    this.id,
    this.link,
    this.imageLink,
    this.title,
    this.description,
  });

  static List<Game> fetchAll() {
    return [
      Game(
        id: 0,
        link: "https://www.ubisoft.com/en-gb/game/rainbow-six/siege",
        imageLink:
            "https://store.ubi.com/dw/image/v2/ABBS_PRD/on/demandware.static/-/Sites-masterCatalog/default/dwdf41a589/images/large/56c494ad88a7e300458b4d5a.jpg?sw=341&sh=450&sm=fit",
        title: "Tom Clancy's Rainbow Six Siege",
        description:
            "Tom Clancy's Rainbow Six Siege is an online tactical shooter video game developed by Ubisoft Montreal and published by Ubisoft. It was released worldwide for Microsoft Windows, PlayStation 4, and Xbox One on December 1, 2015.",
      ),
      Game(
        id: 1,
        link: "https://www.minecraft.net/en-us/",
        imageLink:
            "https://www.minecraft.net/content/dam/minecraft/pdp/Minecraft-xbox-one.jpg",
        title: "Minecraft",
        description:
            "Prepare for an adventure of limitless possibilities as you build, mine, battle mobs, and explore the ever-changing Minecraft landscape. ",
      ),
      Game(
        id: 2,
        link: "https://play.euw.leagueoflegends.com/en_GB",
        imageLink:
            "https://theme.zdassets.com/theme_assets/43400/87a1ef48e43b8cf114017e3ad51b801951b20fcf.jpg",
        title: "League of Legends",
        description:
            "League of Legends is a multiplayer online battle arena video game developed and published by Riot Games for Microsoft Windows and macOS. Inspired by the Warcraft III: The Frozen Throne mod Defense of the Ancients, the game follows a freemium model and is supported by microtransactions.",
      ),
      Game(
        id: 3,
        link: "https://blog.counter-strike.net/",
        imageLink:
            "https://steamcdn-a.akamaihd.net/steam/apps/730/header.jpg?t=1592263625",
        title: "CSGO",
        description:
            "Counter-Strike: Global Offensive is a multiplayer first-person shooter video game developed by Valve and Hidden Path Entertainment. It is the fourth game in the Counter-Strike series and was released for Windows, OS X, Xbox 360, and PlayStation 3 in August 2012, while the Linux version was released in 2014.",
      ),
    ];
  }
}
