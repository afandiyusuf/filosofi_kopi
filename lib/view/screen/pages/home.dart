import 'package:filkop_mobile_apps/view/screen/pick_our_stores_screen.dart';
import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          //TOP SECTION
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    alignment: Alignment.center,
                    height: 100,
                    child: Container(
                        alignment: Alignment.center,
                        height: 70,
                        child: Image.asset('images/logo.png')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Your point",textAlign: TextAlign.left, style: TextStyle(
                              fontSize: 10
                            ),),
                            Text("0 pts", textAlign: TextAlign.left, style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),
                      Container(
                        child: RaisedButton(
                          onPressed: () {},
                          color: Style.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                    size: 16,
                                  )),
                              Text(
                                "Add Point",
                                style: TextStyle(color: Style.primaryTextColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey.shade100,
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.all(30),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.38,
                child: Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(
                        child: Material(
                          color: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10))),
                          child: InkWell(
                            onTap: () {
                              print("YO");
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "Dikirim",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10))),
                          color: Colors.black,
                          child: InkWell(
                            onTap: () {
                              print("YO");
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  "Ambil Sendiri",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.16,
                                  child: InkWell(
                                    onTap: (){
                                      _gotoPickOurStoresScreen(context);
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.075),
                                            child: Text(
                                              "Ambil pesanan KAMU di:",
                                              style: TextStyle(fontSize: 10),
                                            )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                child: Icon(
                                                  Icons.location_on,
                                                  size: 12,
                                                )),
                                            Text(
                                              "Pilih kedai kami",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Material(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft:
                                                    Radius.circular(10))),
                                        color: Colors.black,
                                        child: InkWell(
                                          onTap: () {
                                            print("YO");
                                          },
                                          child: Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                "Ambil Sendiri",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  _gotoPickOurStoresScreen(BuildContext context){
    Navigator.pushNamed(context, PickOurStoresScreen.tag);
  }
}
