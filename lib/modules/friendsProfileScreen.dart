import 'package:flutter/material.dart';

class FriendsProfileScreen extends StatelessWidget {
  String? userUid;
  FriendsProfileScreen(this.userUid);

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Text("friends");
  }
}
