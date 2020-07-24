import 'package:flutter/material.dart';
class AddNoteButton extends StatelessWidget {
  final Function onTap;
  AddNoteButton({this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        height: 50,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
                child: Icon(Icons.add, size: 15,)),
            Text("Add Notes")
          ],
        ),
      ),
    );
  }
}
