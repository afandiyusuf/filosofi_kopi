import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/primary_button.dart';
import 'package:filkop_mobile_apps/view/component/profile_button.dart';
import 'package:filkop_mobile_apps/view/screen/referral_code_screen.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleText: "PROFILE",
        usingBack: false,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 30, bottom: 30),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Rio Dewanto"),
                        Container(
                            margin: EdgeInsets.only(top: 12),
                            child: Text(
                              "dewantoro@gmail.com",
                              style: TextStyle(fontSize: 12),
                            )),
                        Text("+6262362328472", style: TextStyle(fontSize: 12))
                      ],
                    ),
                    PrimaryButton(
                      label: "Edit",
                    )
                  ],
                ),
              ),
            ),
            ProfileButton(
              leadingIcon: Icons.group,
              label: "Referral Code",
              rightIcon: Icon(Icons.navigate_next),
              border: Border(
                  top: BorderSide(color: Colors.black26)),
              onTap: () {
                Navigator.pushNamed(context, ReferralCodeScreen.tag);
              },
            ),
            ProfileButton(
              leadingIcon: Icons.help,
              label: "Help",
              rightIcon: Icon(Icons.navigate_next),
              border: Border(
                  top: BorderSide(color: Colors.black26),
                  bottom: BorderSide(color: Colors.black26)),
              onTap: () {},
            ),
            ProfileButton(
              leadingIcon: Icons.star,
              label: "Rate this App",
              rightIcon: Icon(Icons.navigate_next),
              border: Border(
                  bottom: BorderSide(color: Colors.black26)),
              onTap: () {},
            ),
            ProfileButton(
              padding: EdgeInsets.only(left:12,right: 12, top:30,bottom: 30),
              leadingIcon: Icons.exit_to_app,
              label: "Logout",
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
