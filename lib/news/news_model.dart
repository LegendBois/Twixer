import 'package:Twixer/utils/network_util.dart';

class News {
  NetworkUtil _netUtil = new NetworkUtil();
  int id;
  String link;
  String imageLink;
  String title;
  //String content;

  News({
    this.id,
    this.link,
    this.imageLink,
    this.title,
  });

  static List<News> fetchAll() {
    return [
      News(
          id: 0,
          link: "https://www.ubisoft.com/en-us/forward",
          imageLink:
              "https://staticctf.akamaized.net/J3yJr34U2pZ2Ieem48Dwy9uqj5PNUQTn/3biJZaImvaQEMptXKXjZrf/91a22a0d4003b3775540f4349374d5da/2020_Forward_STD_1920x1080.png",
          title:
              "Ubisoft Forward (US) | Welcome to the official Ubisoft Forward page"),
      News(
          id: 1,
          link: "https://www.pcgamer.com/halo-3-review/",
          imageLink:
              "https://cdn.mos.cms.futurecdn.net/a8MQpVhvMrt54LU7foHPif-1200-80.jpg",
          title: "Halo 3 review"),
      News(
          id: 2,
          link:
              "https://www.pcgamer.com/interview-dr-disrespect-talks-about-his-twitch-ban-the-rumors-and-his-future/",
          imageLink:
              "https://cdn.mos.cms.futurecdn.net/CC3742GRuc9wXCE2rgYZfe-1200-80.jpg",
          title:
              "Interview: Dr Disrespect talks about his Twitch ban, the rumors, and his future | PC Gamer"),
      News(
          id: 3,
          link:
              "https://in.ign.com/tech/148502/feature/mixers-abrupt-end-has-had-painful-consequences",
          imageLink:
              "https://sm.ign.com/t/ign_in/feature/m/mixers-abr/mixers-abrupt-end-has-had-painful-consequences_xe4n.1200.jpg",
          title: "Mixer's Abrupt End Has Had Painful Consequences"),
      News(
          id: 4,
          link:
              "https://in.ign.com/assassins-creed-2020-playstation-5/148883/feature/the-evolution-of-assassins-creed-from-the-holy-land-to-valhalla",
          imageLink:
              "https://sm.ign.com/t/ign_in/feature/t/the-evolut/the-evolution-of-assassins-creed-from-the-holy-land-to-valha_91pc.1200.jpg",
          title:
              "The Evolution of Assassin's Creed: From the Holy Land to Valhalla Assassin's Creed Valhalla")
    ];
  }

/*  _getContent() async {
    Response response = await _netUtil.get(this.link);
    var document = parse(response.body);
    this.title = document.getElementsByTagName("title")[0].firstChild.text;
    print(document.getElementsByTagName("meta")[1].text);
    this.content = document.getElementsByTagName("meta").length.toString();

    this._printContent();
  }

  _printContent() {
    print(this.link);
    print(this.title);
    print(this.content);
  }*/
}
