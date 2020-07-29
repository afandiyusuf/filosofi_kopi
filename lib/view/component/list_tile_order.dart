import 'package:flutter/material.dart';
class ListTileOrder extends StatelessWidget {
  final String name;
  final String total;
  final String price;
  final String image;

  ListTileOrder({this.name, this.total, this.price, this.image});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(image),
      title: Text(name),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("$total barang"),
          Text("Rp $price", style: TextStyle(
              fontSize: 18
          ),)
        ],
      ),
    );
  }
}
