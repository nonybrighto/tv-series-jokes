import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/services/application_service.dart';


class ApplicationBloc extends BlocBase{

  ApplicationService applicationService;

  final _appThemeController = BehaviorSubject<AppThemeType>();

  //streams
  Stream<AppThemeType> get appTheme => _appThemeController.stream;

  //sinks
  Function(AppThemeType)  get changeAppTheme => (appThemeType) => _appThemeController.sink.add(appThemeType);
  

  ApplicationBloc({this.applicationService}){
    
    _setStartupTheme();
    
    _appThemeController.stream.listen((AppThemeType appThemeType){
          applicationService.setDefaultThemeType(appThemeType);
    });

  }

_setStartupTheme() async{
  AppThemeType defaultThemeType = await  applicationService.getDefaultThemeType();
  _appThemeController.sink.add(defaultThemeType);
}

  @override
  void dispose() {
    print('dispose application bloc');
    _appThemeController.close();
  }

}


enum AppThemeType{light, dark}