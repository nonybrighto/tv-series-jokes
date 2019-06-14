import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => new _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  @override
  Widget build(BuildContext context) {
    String logoName = (Theme.of(context).brightness == Brightness.dark)?'logo_light':'logo_dark';
    return Scaffold(
        appBar: AppBar(
          title: Text('About'),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/$logoName.png', width: 250,),
                Text(
                  'Designed By nonybrighto',
                  style: TextStyle(fontSize: 23),
                ),
                Text(
                  'A big fan of TV Series sitcoms such as The Simpsons, ' +
                      'Friends, The Big Bang Theory, How I Met Your Mother, ' +
                      'Two and A Half Men, The Good Place, etc.',
                  textAlign: TextAlign.center,
                ),

                _profileLink('Website', 'http://www.nonybrighto.com',
                    'http://www.nonybrighto.com'),
                _profileLink('Github', 'http://www.github.com/nonybrighto',
                    'http://www.github.com/nonybrighto'),
                _profileLink('Twitter', 'http://www.twitter.com/nonybrighto',
                    'http://www.twitter.com/nonybrighto'),
                _profileLink('Email', 'nonybrighto@gmail.com',
                    'mailto:nonybrighto@gmail.com?subject=Hello%20Nonybrighto&body=Hi'),
                Divider(),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(color: Colors.grey),
                      text:
                          'This project is an open source project designed with my favorite framework,',
                      children: [
                        TextSpan(
                            text: 'Flutter.',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch('https://flutter.dev/');
                              }),
                        TextSpan(text: 'The source code can be found '),
                        TextSpan(
                            text: 'Here.',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch(
                                    'https://github.com/nonybrighto/tv-series-jokes');
                              }),
                      ]),
                )
                // Wrap(
                //   children: <Widget>[
                //     Text('This project is an open source project designed with my favorite framework, '),
                //     Text('Flutter')
                //   ],
                // )
              ],
            ),
          ),
        ));
  }

  _profileLink(String title, String linkTitle, String link) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title + ':'),
        SizedBox(
          width: 10,
        ),
        _link(linkTitle, link)
      ],
    );
  }

  _link(String linkTitle, String link) {
    return GestureDetector(
      child: Text(linkTitle,
          style: TextStyle(
              color: Colors.blue, decoration: TextDecoration.underline)),
      onTap: () {
        launch(link);
      },
    );
  }
}
