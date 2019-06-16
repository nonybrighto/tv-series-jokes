import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tv_series_jokes/blocs/auth_bloc.dart';
import 'package:tv_series_jokes/blocs/auth_page_bloc.dart';
import 'package:tv_series_jokes/blocs/bloc_provider.dart';
import 'package:tv_series_jokes/models/auth.dart';
import 'package:tv_series_jokes/models/load_state.dart';
import 'package:tv_series_jokes/ui/pages/home_page.dart';
import 'package:tv_series_jokes/ui/pages/terms_and_conditions_page.dart';
import 'package:tv_series_jokes/ui/widgets/buttons/general_buttons.dart';
import 'package:tv_series_jokes/ui/widgets/clips/login_bottom_clipper.dart';
import 'package:tv_series_jokes/ui/widgets/clips/login_top_clipper.dart';
import 'package:tv_series_jokes/utils/validator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


enum AuthType { login, signup }

class AuthPage extends StatefulWidget {
  final AuthType authType;
  AuthPage(this.authType, {Key key}) : super(key: key);

  @override
  _AuthPageState createState() => new _AuthPageState();
}

class _AuthPageState extends State<AuthPage>{
  Validator validator;
  BuildContext _context;
  final _formKey = GlobalKey<FormState>();
  AuthType authType;
  AuthPageBloc authPageBloc;

  TextEditingController _usernameController =
      TextEditingController(text: '');
  TextEditingController _emailController =
      TextEditingController(text: '');
  TextEditingController _passwordController =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    validator = Validator();
    authType = widget.authType;
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    authPageBloc = AuthPageBloc(authBloc: authBloc);
  }

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(
        title: Text((authType == AuthType.signup) ? 'Sign up' : 'Login'),
      ),
      body: Builder(
        builder: (context) {
          _context = context;

          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildHeader(),
                _buildAuthForm(),
                _footerHorizontalDivider(),
                _buildSocialButtons(),
                _buildFooter(authType)
              ],
            ),
          );
        },
      ),
    );
  }

  _buildHeader(){
    return Stack(
                  children: <Widget>[
                    ClipPath(
                      clipper: LoginBottomClipper(),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            //decoration: BoxDecoration(color: Color(0Xc0fc6b00)),
                            color: Colors.white24,
                            height: 300,
                          ),
                          Container(
                            decoration: BoxDecoration(color: Color(0Xc0fc6b00)),
                            height: 300,
                          )
                        ],
                      ),
                    ),
                    ClipPath(
                      clipper: LoginTopClipper(),
                      child: Container(
                        height: 260,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Color(0Xfffa7c05),
                              Color(0Xffee3e00)
                            ])),
                      ),
                    ),
                    Center(child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Image.asset('assets/images/logo_light.png',width: 250,),
                    ))
                  ],
                );
  }

  _buildFooter(AuthType authType) {
    if (authType == AuthType.signup) {
      return _buildFootDetail(
          infoText: 'By Signing up, you agree to our',
          buttonText: 'Terms and Conditions',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TermsAndConditionsPage()));
          });
    } else {
      return _buildFootDetail(
          infoText: 'Don\'t have an account?',
          buttonText: 'Sign up',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AuthPage(AuthType.signup)));
          });
    }
  }

  _buildAuthForm() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
            key: _formKey,
              child: Column(
          children: <Widget>[
            (authType == AuthType.signup)
                ? _authFormTextField(
                    hintText: 'Username',
                    controller: _usernameController,
                    icon: Icons.verified_user,
                    validator: validator.usernameValidator)
                : Container(),
            (authType == AuthType.signup) ? SizedBox(height: 10.0) : Container(),
            _authFormTextField(
                hintText: 'Email',
                controller: _emailController,
                icon: Icons.verified_user,
                validator: validator.emailValidator),
            SizedBox(height: 10.0),
            _authFormTextField(
                hintText: 'Password',
                controller: _passwordController,
                icon: Icons.verified_user,
                validator: validator.passwordValidator,
                obscureText: true),
            SizedBox(height: 10.0),
            _buildAuthButton(),
          ],
        ),
      ),
    );
  }

  _authFormTextField(
      {TextEditingController controller,
      String hintText,
      Function(String) validator,
      IconData icon,
      bool obscureText = false}) {

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(icon: Icon(icon), hintText: hintText),
    );
  }

  _buildAuthButton() {
    return StreamBuilder<LoadState>(
        initialData: Loaded(),
        stream: authPageBloc.loadState,
        builder: (context, AsyncSnapshot<LoadState> loadStateSnapShot) {
          LoadState loadState = loadStateSnapShot.data;
          return RoundedButton(
            child:  (_canClickAuthButton(loadState))
                  ? Text(
                      (authType == AuthType.signup) ? 'SIGN UP' : 'LOGIN',
                      style: TextStyle(color: Colors.white),
                    )
                  : CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
            onPressed: (_canClickAuthButton(loadState))
                  ? () {
                      if (_formKey.currentState.validate()) {
                        if (authType == AuthType.signup) {
                          authPageBloc.signUp(_usernameController.text,
                              _emailController.text, _passwordController.text, _authCallBack);
                        } else {
                          authPageBloc.login(
                              _emailController.text, _passwordController.text, _authCallBack);
                        }
                      }
                    }
                  : null,
                  
          );
        });
  }

  _footerHorizontalDivider() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0.0,
          left: 0.0,
          bottom: 0.0,
          top: 0.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Divider(
                color: Theme.of(context).accentColor,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Text('OR'),
            )
          ],
        )
      ],
    );
  }

  _buildFootDetail({String infoText, String buttonText, Function() onPressed}) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: <Widget>[
        Text(infoText),
        FlatButton(
            child: Text(
              buttonText,
              style: TextStyle(color: const Color(0Xfffe0e4f)),
            ),
            onPressed: onPressed)
      ],
    );
  }

  _buildSocialButtons() {
    return StreamBuilder(
        initialData: Loaded(),
        stream: authPageBloc.loadState,
        builder: (context, loadStateSnapShot) {
          LoadState loadState = loadStateSnapShot.data;
          bool buttonClickable = _canClickAuthButton(loadState);
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _socialButton(
                  icon: FontAwesomeIcons.facebookF,
                  clickable: buttonClickable,
                  bgColor: Color(0XFF3f5993),
                  onTapCall: () {
                    authPageBloc.loginWithSocial(SocialLoginType.facebook, _authCallBack);
                  }),
              SizedBox(width: 20.0),
              _socialButton(
                  icon: FontAwesomeIcons.googlePlusG,
                  clickable: buttonClickable,
                  bgColor: Color(0XFFc3533c),
                  onTapCall: () {
                    authPageBloc.loginWithSocial(SocialLoginType.google, _authCallBack);
                  }),
            ],
          );
        });
  }

  _socialButton({IconData icon, Color bgColor, bool clickable, Function() onTapCall}) {
    return InkWell(
      child: CircleAvatar(
        //child: Icon(FontAwesomeIcons.facebookF),
        backgroundColor: bgColor,
        child: Icon(icon),
      ),
      onTap: clickable ? onTapCall : null,
    );
  }

  _authCallBack(bool didLogin, String errorMessage){

        if(didLogin){
            Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        }else{
             Scaffold.of(_context).showSnackBar(SnackBar(
              content: Text('Error: ' + errorMessage),
            ));
        }
  }

_canClickAuthButton(LoadState loadState) {
  return !(loadState is Loading);
}

}


