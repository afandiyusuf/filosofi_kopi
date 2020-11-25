import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                    child: Image.asset("images/food_icon.png")),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text("Status transaksi:",style: TextStyle(fontSize: 10),),
                    SizedBox(width: 5,),
                    Text("Menunggu pembayaran",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),)
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                    child: Text("Ada transaksi yang belum diproses, tap untuk melihat detailnya", style: TextStyle(
                      fontSize: 10
                    ),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
