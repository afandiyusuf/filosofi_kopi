import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String titleText;
  final bool usingBack;

  CustomAppBar({this.titleText, this.usingBack = true});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleText, style: TextStyle(
          color: Colors.black
      ),),
      centerTitle: true,
      elevation: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return Visibility(
            visible: usingBack,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
      backgroundColor: Colors.white,
    );
  }
}


