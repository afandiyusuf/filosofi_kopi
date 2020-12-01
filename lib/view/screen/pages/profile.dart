import 'package:filkop_mobile_apps/model/get_user_result.dart';
import 'package:filkop_mobile_apps/service/api_service.dart';
import 'package:filkop_mobile_apps/view/component/custom_app_bar.dart';
import 'package:filkop_mobile_apps/view/component/primary_button.dart';
import 'package:filkop_mobile_apps/view/component/profile_button.dart';
import 'package:filkop_mobile_apps/view/screen/address_screen.dart';
import 'package:filkop_mobile_apps/view/screen/referral_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/flutter_placeholder_textlines.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Future<GetUserResult> _getUserResult = ApiService().getUser();
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
                    FutureBuilder<GetUserResult>(
                      future:_getUserResult,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.done) {
                          if(snapshot.hasData) {
                            UserProfile userProfile =  snapshot.data.data.data;

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("${userProfile.firstName} ${userProfile.lastName}"),
                                Container(
                                    margin: EdgeInsets.only(top: 12),
                                    child: Text(
                                      "${userProfile.email}",
                                      style: TextStyle(fontSize: 12),
                                    )),
                                Text("${userProfile.phone}",
                                    style: TextStyle(fontSize: 12))
                              ],
                            );
                          }else{
                            return Center(child:Text("Terjadi kesalahan"));
                          }
                        }else{
                          return Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                PlaceholderLines(count: 1),
                                Container(
                                    margin: EdgeInsets.only(top: 12),
                                    child:PlaceholderLines(count: 1,)),
                                PlaceholderLines(count: 1,)
                              ],
                            ),
                          );
                        }
                      }
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
              onTap: ()  async {
                if(await canLaunch("https://filosofikopi.id/faq")){
                  launch("https://filosofikopi.id/faq");
                  return;
                }
                Fluttertoast.showToast(msg: "Terjadi kesalahan coba lagi nanti");
              },
            ),
            ProfileButton(
              leadingIcon: Icons.map,
              label: "Manage Address",
              rightIcon: Icon(Icons.navigate_next),
              border: Border(
                  top: BorderSide(color: Colors.black26),
                  bottom: BorderSide(color: Colors.black26)),
              onTap: () {
                Navigator.pushNamed(context, AddressPage.tag);
              },
            ),
            ProfileButton(
              leadingIcon: Icons.star,
              label: "Rate this App",
              rightIcon: Icon(Icons.navigate_next),
              border: Border(
                  bottom: BorderSide(color: Colors.black26)),
              onTap: () async {
                if(await canLaunch("https://play.google.com/store")){
                launch("https://play.google.com/store");
                return;
                }
                Fluttertoast.showToast(msg: "Terjadi kesalahan coba lagi nanti");
              },
            ),
            ProfileButton(
              padding: EdgeInsets.only(left:12,right: 12, top:30,bottom: 30),
              leadingIcon: Icons.exit_to_app,
              label: "Logout",
              onTap: () async {
                Future<SharedPreferences> pref = SharedPreferences.getInstance();
                SharedPreferences _pref = await pref;
                _pref.clear();
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
