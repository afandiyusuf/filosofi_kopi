import 'package:filkop_mobile_apps/view/component/add_note_button.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/custom_text_field_decoration.dart';
import 'package:filkop_mobile_apps/view/component/detail_thumbnail.dart';
import 'package:flutter/material.dart';

class DetailPageScreen extends StatefulWidget {
  static final String tag = '/detail-page';
  static final String argTitle = 'title';
  static final String argImage = 'images';
  static final String argPrice = 'price';
  String title;
  String image;
  String price;

  @override
  _DetailPageScreenState createState() => _DetailPageScreenState();
}

class _DetailPageScreenState extends State<DetailPageScreen> {
  bool noteAdded = false;
  int _total = 0;
  TextEditingController _nominalTextController;
  @override
  void initState(){
    super.initState();
    _nominalTextController = TextEditingController(text:"0");
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    final Size size = MediaQuery.of(context).size;
    if (arguments != null) {
      widget.title = arguments[DetailPageScreen.argTitle];
      widget.image = arguments[DetailPageScreen.argImage];
      widget.price = arguments[DetailPageScreen.argPrice];
    }

    return Scaffold(
      appBar: CustomAppBar(
        titleText: widget.title,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              DetailThumbnail(
                image: widget.image,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  widget.title.toUpperCase(),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Rp. ${widget.price}",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  widget.title,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ),
              Visibility(
                visible: !noteAdded,
                child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: AddNoteButton(onTap: () {
                      setState(() {
                        noteAdded = true;
                      });
                    })),
              ),
              Visibility(
                visible: noteAdded,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextField(
                    autofocus: true,
                    decoration: CustomMultiTextInputDecoration.create(),
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: size.width * 0.4,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              _setTotal(-1);
                            },
                            child: Container(
                                width: 40,
                                height: 40,
                                child: Center(child: Text("-"))),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              width: 30,
                              height: 30,
                              child: Center(
                                child: Text("${_total}", style: TextStyle(
                                  fontSize: 18
                                ),
                                ),
                              )),
                          InkWell(
                            onTap: () {
                              _setTotal(1);
                            },
                            child: Container(
                                width: 40,
                                height: 40,
                                child: Center(child: Text("+"))),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: size.width * 0.4,
                        height: 50,
                        child: Center(
                            child: Text(
                          "Add to cart",
                          style: TextStyle(color: Colors.white),
                        )),
                        decoration: BoxDecoration(color: Colors.black),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  dispose(){
    _nominalTextController.dispose();
    super.dispose();
  }
  _setTotal(int total)
  {
    setState(() {
      _total+= total;
      if(_total < 0){
        _total = 0;
        _nominalTextController.text = _total.toString();
      }
      print("total is ${_total}");
    });
  }
}
