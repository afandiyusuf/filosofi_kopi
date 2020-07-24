import 'package:filkop_mobile_apps/view/theme/style.dart';
import 'package:flutter/material.dart';


class OrderBox extends StatelessWidget {
  final Function onPressed;
  OrderBox({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 30, left: 30, right: 30,bottom: 0),
      width: MediaQuery.of(context).size.width * 0.8,
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
                        MediaQuery.of(context).size.height * 0.13,
                        child: InkWell(
                          onTap: (){
                            onPressed();
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .size
                                          .height *
                                          0.05),
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
    );
  }
}

