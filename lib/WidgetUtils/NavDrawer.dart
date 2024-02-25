import 'package:flutter/material.dart';

import 'package:sg_carpark_availability/Controller/Auth.dart';

class NavDrawer extends StatelessWidget {
  late final String userName;
  final AuthBase auth;

  NavDrawer({ Key? key, required this.auth}) : super(key: key) {
    if (auth.currentUser!.isAnonymous) {
      userName = auth.currentUser!.uid;
    }
      else {
      userName = auth.currentUser!.email!;
    }
  }


  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 100,
            child: DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.amber.shade300,
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage("assets/user.png"))),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0.0), child: null,),
          ),
          Container(
            padding: EdgeInsets.zero,
            height: 100,
            color: Colors.amber.shade300,
            child: Center(child: Text('Current User: $userName')),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {_signOut()},
          ),
        ],
      ),
    );
  }
}
