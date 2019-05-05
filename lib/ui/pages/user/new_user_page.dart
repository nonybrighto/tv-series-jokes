import 'package:flutter/material.dart';

class NewUserPage extends StatefulWidget {
  NewUserPage({Key key}) : super(key: key);

  @override
  _NewUserPageState createState() => new _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: <Widget>[
          Container(
            height: 200,
            color: Colors.red,
            child: Text('Hello World'),
          ),
          Stack(
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 50,
                  itemBuilder: (a, b){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Crap'),
                    );
                  },
                ),
            ],
          ),
          
        ],
      ),
    );
  }
}