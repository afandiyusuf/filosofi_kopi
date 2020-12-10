import 'package:flutter/material.dart';

class VoucherThumbnail extends StatelessWidget {
  final Function onTap;

  const VoucherThumbnail({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 180,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 75,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                              child: Image.asset(
                                "images/gambar1.jpeg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [Colors.black, Colors.transparent])),
                            ),
                          ),
                          Positioned(
                              bottom: 10,
                              left: 20,
                              child: Text(
                                "KUPON MERDEKA",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                              ))
                        ],
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Row(
                                children: [
                                  Icon(Icons.lock_clock),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Berlaku hingga",
                                        style: TextStyle(fontSize: 11),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "2020-10-30",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: Row(
                                children: [
                                  Icon(Icons.monetization_on),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Point yang dibutuhkan",
                                          style: TextStyle(fontSize: 11),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          "300",
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ))
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: -5,
              top: 75,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
              ),
            ),
            Positioned(
              right: -5,
              top: 75,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(100)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
