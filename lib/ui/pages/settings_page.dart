import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/application_bloc.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'),),
      body: ListView(
        children: <Widget>[
          _buildSwapThemeSettingTile(),
          Divider(),
        ],
      ),
    );
  }

  _buildSwapThemeSettingTile(){
    ApplicationBloc applicationBloc = BlocProvider.of<ApplicationBloc>(context);
      return ListTile(
            title: Text('Change Default Theme'),
            subtitle: Text('on for dark and off for light'),
            trailing: StreamBuilder<AppThemeType>(
              stream: BlocProvider.of<ApplicationBloc>(context).appTheme,
              builder: (context, appThemeSnapshot) {
                return Switch(
                  value: (appThemeSnapshot.data == AppThemeType.dark)?true:false,
                  onChanged: (value){
                    applicationBloc.changeAppTheme((value == true)? AppThemeType.dark: AppThemeType.light);
                  },
                );
              }
            ),
          );
  }
}