import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.grey.shade300,
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Profile'),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTile(
              leading: CupertinoIcons.photo,
              title: "Picture",
              onTap: () {
           
              },
              topLeft: 7,
              topRight: 7,
            ),
            CustomTile(
                leading: CupertinoIcons.person,
                title: "Your Profile",
                onTap: () {}),
            CustomTile(
                leading: CupertinoIcons.location,
                title: "Your Location",
                onTap: () {}),
            CustomTile(
                leading: CupertinoIcons.mail,
                title: "Contact Admin",
                onTap: () {}),
            CustomTile(
              leading: CupertinoIcons.square_arrow_right,
              title: "SignOut",
              onTap: () {},
              bottomLeft: 7,
              bottomRight: 7,
            ),
          ],
        ),
      ),
    );
  }
}
