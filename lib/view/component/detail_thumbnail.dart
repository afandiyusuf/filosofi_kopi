import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DetailThumbnail extends StatelessWidget {
  final String image;

  DetailThumbnail({this.image});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
          child:  CachedNetworkImage(
            imageUrl: image,
            placeholder: (context, url) => Padding(
              padding: const EdgeInsets.all(25.0),
              child: CircularProgressIndicator(),
            ),
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
