import 'package:flutter/material.dart';
class ListTileOrder extends StatelessWidget {
  final String name;
  final String total;
  final String price;
  final String image;
  final Function onTap;
  final Function onDeleteTap;

  ListTileOrder({this.name, this.total, this.price, this.image, this.onTap, this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: ListTile(
        leading: Image.network(image),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
                child: Text(name, maxLines: 1, softWrap: true,)),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(0),
              width: 40,
              height: 30,
              margin: EdgeInsets.only(bottom: 10),
              child: RaisedButton(
                color: Colors.redAccent,
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                onPressed: (){
                  onDeleteTap();
                },
                child: Center(child: Icon(Icons.delete, color: Colors.white, size: 18,)),
              ),
            )
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("$total barang"),
            Text("$price", style: TextStyle(
                fontSize: 13
            ),)
          ],
        ),
      ),
    );
  }
}
