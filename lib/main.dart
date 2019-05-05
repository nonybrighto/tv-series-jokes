import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/application_bloc.dart';
import 'package:tv_series_jokes/blocs/auth_bloc.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/services/application_service.dart';
import 'package:tv_series_jokes/services/auth_service.dart';
import 'package:tv_series_jokes/ui/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApplicationBloc applicationBloc =
        ApplicationBloc(applicationService: ApplicationService());
    return BlocProvider<ApplicationBloc>(
      bloc: applicationBloc,
      child: BlocProvider<AuthBloc>(
        bloc: AuthBloc(authService: AuthService()),
        child: StreamBuilder<AppThemeType>(
            initialData: AppThemeType.dark,
            stream: applicationBloc.appTheme,
            builder: (context, appThemeSnapshot) {
              return MaterialApp(
                title: 'Flutter Demo',
                theme: (appThemeSnapshot.data == AppThemeType.dark)
                    ? _buildDarkTheme()
                    : _buildLightTheme(),
                home: HomePage(),
              );
            }),
      ),
    );
  }

  _buildDarkTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0XFF212845),
        accentColor: const Color(0XFFfc6b00),
        scaffoldBackgroundColor: const Color(0XFF212845),
        primarySwatch: Colors.orange,
        buttonColor: const Color(0XFFfc6b00),
        canvasColor: const Color(0XFF212845),
        dividerColor: const Color(0XFF676b67),
        cardColor: const Color(0X252836),
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent));
  }

  _buildLightTheme() {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0XFF212845),
        accentColor: const Color(0XFFfc6b00),
        primarySwatch: Colors.orange,
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent));
  }
}
