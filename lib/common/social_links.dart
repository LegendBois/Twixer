import 'package:flutter/material.dart';

class SocialLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        constraints: BoxConstraints.expand(
          height: 80.0,
        ),
        padding: EdgeInsets.only(left: 16.0),
        decoration: BoxDecoration(color: Colors.black),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Text(
              "Social Links",
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.left,
            )),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Image.asset(
                    "assets/logos/youtube.png",
                    fit: BoxFit.fitHeight,
                  )),
                  Expanded(
                      child: Image.asset(
                    "assets/logos/twitch.png",
                    fit: BoxFit.fitHeight,
                  )),
                  Expanded(
                      child: Image.asset(
                    "assets/logos/twitter.png",
                    fit: BoxFit.fitHeight,
                  )),
                  Expanded(
                      child: Image.asset(
                    "assets/logos/reddit.png",
                    fit: BoxFit.fitHeight,
                  )),
                ],
              ),
            ),
          ],
        ));
  }
}
