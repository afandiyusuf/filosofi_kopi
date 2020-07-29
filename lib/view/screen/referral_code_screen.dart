import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/primary_button.dart';
import 'package:flutter/material.dart';

class ReferralCodeScreen extends StatelessWidget {
  static final tag = '/referral-code';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleText: "Referral Code",),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("ALDHJ1236"), PrimaryButton(label: "Copy",onPressed: (){

                  },)
                ],
              ),
            ),
            ExpansionTile(
              leading: Icon(Icons.help),
              title: Text("What is referral code?"),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:20,right: 20, top:10, bottom: 10),
                  child: Text("l asdlasj dlkasjd laksjd alsdj alsdjalskdj alsdj alsdj alsdjl asdjlaks dlkasjd lasjdlk asdjlkas jd"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
