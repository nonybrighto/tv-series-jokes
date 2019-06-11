import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatefulWidget {


  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {

  String terms = '';
  @override
  void initState(){
    super.initState();
    _getTerms();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terms and Conditions'),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Text(terms),
      ),
    );
  }

   _getTerms() async{

      String gottenTerms = await  DefaultAssetBundle.of(context).loadString('assets/texts/terms_and_conditions.txt');
      setState((){
          terms = gottenTerms;
      });
  }
}