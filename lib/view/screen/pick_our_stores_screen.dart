import 'package:filkop_mobile_apps/model/store_datas.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PickOurStoresScreen extends StatefulWidget {
  static final String tag = '/pick-our-stores';

  @override
  _PickOurStoresScreenState createState() => _PickOurStoresScreenState();
}

class _PickOurStoresScreenState extends State<PickOurStoresScreen> {
  StoreDatas _storeDatas = StoreDatas();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = 150;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: CustomAppBar(titleText: "Pick Our Stores"),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
            child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                childAspectRatio: (itemWidth / itemHeight),
                children: List.generate(_storeDatas.getTotalStore(), (index) {
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            height: 150,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                _storeDatas.getStoreByIndex(index).image,
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(_storeDatas.getStoreByIndex(index).name.toUpperCase(), style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold,shadows: <Shadow>[
                              Shadow(
                                offset: Offset(2.0, 2.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              )
                            ]
                            ),),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(6),bottomRight: Radius.circular(6)),
                            color: Colors.white.withOpacity(0.9),
                          ),
                          child: Text(_storeDatas.getStoreByIndex(index).location, style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                      )
                    ],
                  );
                }))),
      ),
    );
  }
}
