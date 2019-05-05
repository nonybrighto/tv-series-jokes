import 'package:flutter/material.dart';

class MainErrorDisplay extends StatelessWidget {

  final String errorMessage;
  final String buttonText;
  final Function onErrorButtonTap;
 
  MainErrorDisplay({this.errorMessage, this.buttonText, this.onErrorButtonTap});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.sentiment_dissatisfied,size: 150, color: Theme.of(context).accentColor,),
            Text(this.errorMessage ?? 'Error occured', style: TextStyle(fontSize: 15),),
            FlatButton(
                child: Text(buttonText ?? 'RETRY', style: TextStyle(fontSize: 18),),
                onPressed: onErrorButtonTap,
            ),
          ],
        ),
    );
  }
}