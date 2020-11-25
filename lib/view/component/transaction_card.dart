import 'package:filkop_mobile_apps/model/get_transaction_result.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';


class TransactionCard extends StatefulWidget {
  final Transaction transaction;
  final Function onTap;
  const TransactionCard({Key key, this.transaction, this.onTap}) : super(key: key);

  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset("images/food_icon.png")),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text("Kode Transaksi", style: TextStyle(fontSize: 10),),
                          SizedBox(width: 10,),
                          Text("${widget.transaction.code}", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      Row(
                        children: [

                          Text(
                            "Status transaksi:",
                            style: TextStyle(fontSize: 10),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${widget.transaction.statusName}",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "${ DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY).format(widget.transaction.createdDate)}",
                            style: TextStyle(fontSize: 10),
                          )),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              right: 5,
                bottom: 5,
                child: Container(
                  height: 25,
                  child: RaisedButton(
                    color: Colors.black,
                    padding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
              shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    "Tap untuk melihat detail",
                    style: TextStyle(fontSize: 8, color: Colors.white),
                  ),
              ),
              onPressed: widget.onTap,
            ),
                ))
          ],
        ),
      ),
    );
  }
}
