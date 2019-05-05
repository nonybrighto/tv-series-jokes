import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Widget child;
  final Function() onPressed;
  RoundedButton({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(colors:(onPressed!=null)? [Color(0Xfffa7c05), Color(0Xffee3e00)] : [Color(0Xfffa7c05), Color(0Xffee3e00)]),
            ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: child,
              )),
        ),
      ),
    );
  }
}
