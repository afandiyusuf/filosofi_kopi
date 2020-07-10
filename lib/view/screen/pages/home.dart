import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(top:15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width*0.75,
                  margin: EdgeInsets.only(top:0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Dikirim"),
                      )
                    ],
                  ),
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}
