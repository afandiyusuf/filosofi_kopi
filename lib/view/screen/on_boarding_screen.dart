import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/view/screen/main_screen.dart';
import 'package:filkop_mobile_apps/view/screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  static final String tag = '/on-boarding';

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List _benefits = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque ultricies sem eu lectus rhoncus convallis.",
    "Integer ornare lectus non eros faucibus, non dapibus nisi congue. Cras maximus finibus felis,",
    "Nam bibendum sem dolor, ut ultrices est maximus id. Praesent semper varius ornare."
  ];
  List _titleBenefits = ["Title 1", "Title 2", "Title 3"];
  int _stateButton = 0;
  List _stateBool = [true, false, false];
  List _colors = [Colors.black, Colors.white, Colors.white];
  bool _visibleNextButton = true;



  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 0),
            child: Container(
              alignment: AlignmentDirectional.topStart,
              child: Visibility(
                visible: (_stateButton != 0) ? true : false,
                child: MaterialButton(
                  key:Key('back-button'),
                  minWidth: 0,
                  onPressed: () {
                    _back();
                  },
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
          ),
          Container(
            alignment: AlignmentDirectional.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  key:Key('icon'),
                  width:100,
                    child: Image.asset('images/logo-font.png')),
                Container(
                  key:Key('title'),
                  margin: EdgeInsets.only(top: 0, bottom: 20),
                  child: Text(
                    _titleBenefits[_stateButton],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  key:Key('description'),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    _benefits[_stateButton],
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      key:Key('indicator-1'),
                      onTap: () {
                        _goToState(0);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20, left: 5, right: 5),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _colors[0],
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                    InkWell(
                      key:Key('indicator-2'),
                      onTap: () {
                        _goToState(1);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20, left: 5, right: 5),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _colors[1],
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                    InkWell(
                      key:Key('indicator-3'),
                      onTap: () {
                        _goToState(2);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 20, left: 5, right: 5),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _colors[2],
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MaterialButton(
                    onPressed: (){
                      _skip(context);
                    },
                    child: Text("Skip"),
                  ),
                  Visibility(
                    visible: _visibleNextButton,
                    child: MaterialButton(
                      key:Key('next-button'),
                      minWidth: 0,
                      padding: EdgeInsets.only(left:10,right: 5,top:5,bottom: 5),
                      color: Style.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Style.roundRadius),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Next",
                            style: TextStyle(color: Style.primaryTextColor,fontSize: 12),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 80),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Style.primaryTextColor,
                                textDirection: TextDirection.ltr,
                                size: 20,
                              ))
                        ],
                      ),
                      onPressed: () {
                        _next(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  _next(BuildContext context) {
    if(_stateButton == 2){
      _stateButton = 0;
      _gotoNextScreen(context);
      _updateOtherVariable();
      return;
    }
    setState(() {
      _stateButton++;
    });
    _updateOtherVariable();
  }

  _back() {
    if(_stateButton == 0){
      return;
    }
    setState(() {
      _stateButton--;

    });
    _updateOtherVariable();
  }

  _goToState(int state) {
    setState(() {
      _stateButton = state;
    });
    _updateOtherVariable();
  }

  _updateOtherVariable() {
    setState(() {
      for (var i = 0; i < _stateBool.length; i++) {
        _colors[i] = Colors.white;
        if (i == _stateButton) {
          _colors[i] = Colors.black;
        }
      }
    });
  }
  _skip(BuildContext context){
    _gotoNextScreen(context);
  }
  _gotoNextScreen(BuildContext context){
    Navigator.popAndPushNamed(context, SignInScreen.tag);
  }
}
