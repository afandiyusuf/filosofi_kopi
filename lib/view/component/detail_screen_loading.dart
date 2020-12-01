import 'package:filkop_mobile_apps/view/component/detail_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';
class DetailScreenLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: size.width*0.02),
              width: size.width * 0.95,
              height: size.width * 0.95,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black12)
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset("images/placeholder.png",fit: BoxFit.cover,) ,
                  ),
                ),
              ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: PlaceholderLines(
                count: 1,
              ),
            ),
            SizedBox(height: 20,),
//            Container(
//              child: Row(
//                children: [
//                  Align(
//                    alignment: Alignment.bottomLeft,
//                    child: Container(
//                      alignment: Alignment.bottomLeft,
//                      margin: EdgeInsets.only(top: 10),
//                      child: PlaceholderLines(count: 1,),
//                    ),
//                  ),
//                  Spacer(),
//                ],
//              ),
//            ),
            Divider(),
            PlaceholderLines(count: 5,),
            Divider(),
//                  Container(
//                    margin: EdgeInsets.only(top: 10),
//                    child: Text(
//                      apparel.name.toUpperCase(),
//                      style: TextStyle(color: Colors.black, fontSize: 15),
//                    ),
//                  ),
           PlaceholderLines(count: 6),
          ],
        ),
      ),
    );
  }
}
