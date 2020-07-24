import 'package:flutter/material.dart';
class CategoryButton extends StatefulWidget {
  String name;
  bool selected;
  Function onTap;
  double width;
  CategoryButton({this.name, this.selected, this.onTap, this.width});
  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {

    TextStyle selectedTextStyle = TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold
    );
    TextStyle idleTextStyle = TextStyle(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.bold
    );
    BoxDecoration selectedBoxDecoration = BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 2, color: Colors.black)
    );
    BoxDecoration idleBoxDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 2, color: Colors.black)
    );

    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        width: this.widget.width,
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Center(child: Text(widget.name,
            style: widget.selected == true
                ? selectedTextStyle
                : idleTextStyle,)),
        ),
        decoration: widget.selected == true
            ? selectedBoxDecoration
            : idleBoxDecoration,
      ),
    );
  }
}
