import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String image;
  final int id;
  final String price;
  final String name;
  final String category;
  final Function onTap;
  final int total;

  ProductCard({this.id, this.name, this.price, this.category, this.image, this.onTap, this.total});
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
        child: Stack(
          children: [
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          height: MediaQuery.of(context).size.width * 0.4,
                          imageUrl: image,
                          placeholder: (context, url) => Container(
                              height: MediaQuery.of(context).size.width * 0.4,
                              child: Image.asset("images/placeholder.png")),
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
                        Text(name, style: titleStyle,overflow: TextOverflow.ellipsis,),
                        Text("$price")
                      ],
                    )),

                  ],
                )),
            Visibility(
              visible: (total > 0)?true:false,
              child: Positioned(
                right: 5,
                bottom: 80,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Container(
                    width: 30,
                    height: 30,
                    child: Center(child: Text("$total", style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

