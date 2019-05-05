import 'package:flutter/material.dart';

class JokeActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final Function onTap;
  final Color iconColor;
  final Color textColor;
  final double size;

  JokeActionButton(
      {this.title,
      this.icon,
      this.selected,
      this.onTap,
      this.iconColor,
      this.textColor,
      this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(60.0)),
      splashColor: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              color: (selected) ? Colors.orange : iconColor,
              size: size ?? Theme.of(context).iconTheme.size,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              title,
              style: TextStyle(
                  color: (selected) ? Colors.orange : textColor ?? Colors.grey,
                  fontSize: size ?? Theme.of(context).textTheme.body1.fontSize),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
