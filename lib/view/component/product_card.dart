import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final int id;
  final int price;
  final String name;
  final int category;

  ProductCard({this.id, this.name, this.price, this.category, this.image});
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15
    );
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          height: 150,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin:EdgeInsets.only(top: 20),
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(this.name, style: titleStyle,),
                  Text("RP ${this.price.toString()}")
                ],
              )),

            ],
          )),
    );
  }
}

