import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final int id;
  final String price;
  final String name;
  final int category;
  final Function onTap;

  ProductCard({this.id, this.name, this.price, this.category, this.image, this.onTap});
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15
    );
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: (){
          onTap();
        },
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      placeholder: (context, url) => Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error)
                    ),
                  ),
                ),
                Container(
                  margin:EdgeInsets.only(top: 20),
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name, style: titleStyle,),
                    Text("$price")
                  ],
                )),

              ],
            )),
      ),
    );
  }
}

