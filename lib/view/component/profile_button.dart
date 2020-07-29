import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final leadingIcon;
  final Icon rightIcon;
  final String label;
  final Function onTap;
  final Border border;
  final EdgeInsetsGeometry padding;
  ProfileButton({this.leadingIcon, this.label, this.onTap, this.border, this.rightIcon, this.padding = const EdgeInsets.all(12.0)});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: border,
        ),
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(leadingIcon),
                    Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Text(label)),
                  ],
                ),
              ),
              Container(
                child:  this.rightIcon,
              )
            ],
          ),
        ),
      ),
    );
  }
}
