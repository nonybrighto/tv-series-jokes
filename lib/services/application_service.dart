import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_series_jokes/blocs/application_bloc.dart';
import 'package:tv_series_jokes/constants/constants.dart';

class ApplicationService{


  Future<AppThemeType> getDefaultThemeType() async{
    
       SharedPreferences pref = await SharedPreferences.getInstance();
       String themeTypeString = pref.getString(kAppThemeTypePrefKey);
       if(themeTypeString == kAppThemeDark){
         return AppThemeType.dark;
       }
       return AppThemeType.light;
  }

  setDefaultThemeType(AppThemeType themeType) async{

      SharedPreferences pref = await SharedPreferences.getInstance();
      if(themeType == AppThemeType.light){
        await pref.setString(kAppThemeTypePrefKey, kAppThemeLight);
      }else{
        await pref.setString(kAppThemeTypePrefKey, kAppThemeDark);
      }

  }
}