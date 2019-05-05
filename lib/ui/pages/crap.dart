// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:tv_series_jokes/blocs/bloc_provider.dart';
// import 'package:ultimate_mtg/dropdownmenu.dart';
// import 'package:ultimate_mtg/model/colorBloc.dart';

// class SinglePlayerMode extends StatefulWidget {
//   @override
//   SinglePlayerModeParentState createState() => SinglePlayerModeParentState();
// }

// class SinglePlayerModeParentState extends State<SinglePlayerMode> {

//   ColorBloc colorBloc = ColorBloc(); // our color bloc instance

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIOverlays([]);
//     SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft,]);
//     Screen.keepOn(true);
//   }

//   @override
//   dispose() {
//     colorBloc.dispose();
//     super.dispose();
//   }

//   _changeColourButton() {
//     colorBloc.changeColor();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => _exitApp(context),
//       child: Scaffold(
//         body: BlocProvider<ColorBloc>( // DropDownMenu can now access the bloc with this
//             bloc: colorBloc,
//             child: Container(
//           child: Row(
//             children: <Widget> [
//               FloatingActionButton(
//                 backgroundColor: Colors.blue,
//                 heroTag: null,
//                 onPressed: _changeColourButton,
//                 child: Text(
//                   'change',
//                 ),
//               ),
//               dropDownMenu(
//                 singlePlayerCallbacks: callBacks,
//               ),
//             ],
//           ),
//         ),   
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:ultimate_mtg/model/colorBloc.dart';
// import 'package:ultimate_mtg/model/blocprovider.dart';

// // ignore: camel_case_types
// class dropDownMenu extends StatefulWidget {
//   final Function() onPressed;
//   final String tooltip;
//   final IconData icon;
//   final _callback;

//   dropDownMenu({Key key, this.onPressed, this.tooltip, this.icon, @required void singlePlayerCallbacks(String callBackType), @required StatefulWidget styleMenu }  ):
//       _callback = singlePlayerCallbacks;

//   @override
//   dropDownMenuState createState() => dropDownMenuState();
// }

// // ignore: camel_case_types
// class dropDownMenuState extends State<dropDownMenu>
//     with SingleTickerProviderStateMixin {
//   bool isOpened = false;
//   AnimationController _animationController;
//   Animation<double> _translateButton;
//   Curve _curve = Curves.easeOut;
//   double _fabHeight = 58;
//   double menuButtonSize = 55;
//   Color menuButtonTheme;
//   ColorBloc colorBloc; // we no longer create the instance here.

//   @override
//   initState() {
//     _animationController =
//     AnimationController(vsync: this, duration: Duration(milliseconds: 600))
//       ..addListener(() {
//         setState(() {});
//       });
//     _translateButton = Tween<double>(
//       begin: 0.0,
//       end: _fabHeight,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Interval(
//         0.0,
//         1.0,
//         curve: _curve,
//       ),
//     ));


//     colorBloc = BlocProvider.of<ColorBloc>(context); // Getting the color bloc from the widget tree
//     super.initState();
//   }

//   @override
//   dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   animate() {
//     if (!isOpened) {
//       _animationController.forward();
//     } else {
//       _animationController.reverse();
//     }
//     isOpened = !isOpened;
//   }

//   Widget backgroundColour() {
//     return StreamBuilder(
//       initialData: Colors.blue,
//       stream: colorBloc.colorStream,
//       builder: (BuildContext context, snapShot) => Container(
//         width: menuButtonSize,
//         height: menuButtonSize,
//         child: RawMaterialButton(
//           shape: CircleBorder(),
//           fillColor: Colors.black,
//           elevation: 5.0,
//           onPressed: (){},
//           child: Container(
//             height: menuButtonSize - 3,
//             width: menuButtonSize - 3,
//             decoration: BoxDecoration(
//               color: snapShot.data,
//               shape: BoxShape.circle,
//             ),
//             child: Image.asset(
//               'lib/images/background_colour.png',
//               scale: 4,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget toggle() {
//     return Transform.rotate(
//       angle: _animationController.value * (pi * 2),
//       child: Container(
//         width: menuButtonSize,
//         height: menuButtonSize,
//         child: RawMaterialButton(
//           shape: CircleBorder(),
//           fillColor: Colors.black,
//           elevation: 5.0,
//           onPressed: animate,
//           child: SizedBox(
//             height: menuButtonSize - 3,
//             width: menuButtonSize - 3,
//             child: Image.asset('lib/images/ic_launcher.png'),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return Stack(
//       children: <Widget> [
//        // Removed the BlocProvider widget here. It wasn't working anything and was creating a separate bloc instance
//        // I also see why you tried to make us of the blocprovider in the backgroundColour method and it gave null.Couldn't
//        // have worked from that context.
//        Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Stack(
//                 children: <Widget>[
//                   Transform(
//                     transform: Matrix4.translationValues(
//                       0,
//                       _translateButton.value,
//                       0,
//                     ),
//                     child: backgroundColour(),
//                   ),
//                   toggle(),
//                 ],
//               ),
//             ],
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               height: menuButtonSize,
//               width: menuButtonSize,
//               child: Opacity(
//                 opacity: 0.0,
//                 child: FloatingActionButton(
//                   heroTag: null,
//                   onPressed: animate,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 3.0,
//             ),
//             Container(
//               height: menuButtonSize,
//               width: menuButtonSize,
//               child: Opacity(
//                 opacity: 0.0,
//                 child: FloatingActionButton(
//                   heroTag: null,
//                   onPressed:  isOpened == true? (){
//                     widget?._callback('background');
//                   } : () {},
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }