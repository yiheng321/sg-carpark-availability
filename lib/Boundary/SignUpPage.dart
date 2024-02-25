import 'dart:async';

import 'package:sg_carpark_availability/Controller/Auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sg_carpark_availability/WidgetUtils/FormCardSignUp.dart';

import 'package:sg_carpark_availability/WidgetUtils/PopupWindows.dart';
import 'package:sg_carpark_availability/Controller/Validation.dart';


final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class SignUpPage extends StatelessWidget  {
  const SignUpPage({Key ? key, required this.auth}) : super(key: key);
  final AuthBase auth;
  static const routeName = '/signup';


  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil ().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(.2),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(context);
    ScreenUtil.init(context);
    return Scaffold(
        key: _scaffoldKey,

        backgroundColor: Colors.amber.shade100,
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Image.asset('assets/image_01.png')
                ),
                Expanded(
                  child: Container(),
                ),
                Image.asset('assets/image_02.png'),
              ],

            ),

            SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.only(left: 23.0, right: 28.0, top: 25.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(left: 290),
                            child: Column(
                              // button for goes back to loginPage
                              children: [
                                IconButton(icon: Icon(Icons.login_rounded,size: 38,color: Colors.brown,),
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    }),
                                Text('to Login',style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            )
                        ),

                        Row(
                          children: <Widget>[
                            Text(
                                'sg_carpark_availability ',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Bold',
                                  fontSize: ScreenUtil ().setSp(52),
                                  letterSpacing: 1.7,
                                  fontWeight: FontWeight.bold,
                                )
                            ),


                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil ().setHeight(130),
                        ),
                        FormCard_signup('signup'),
                        SizedBox(
                          height: ScreenUtil().setHeight(35),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                  width: ScreenUtil().setWidth(300),
                                  height: ScreenUtil().setHeight(100),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [Color(0xFF17ead9), Color(0xFF6078ea)]
                                    ),
                                    borderRadius: BorderRadius.circular(6.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xFF6078ea).withOpacity(.3),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 8.0,
                                      )
                                    ],
                                  ),
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                          onTap: () {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(duration: Duration(seconds: 1), content:
                                                Row(
                                                  children: <Widget>[
                                                    CircularProgressIndicator(),
                                                    Text("  Signing-In...")
                                                  ],
                                                ),
                                                ));

                                            Validation().Signup();
                                            Timer(Duration(seconds: 1), () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) => Popwindow().Popupwindow(context,'sign up',Validation().validateSignup()),
                                              );
                                            } );

                                          },
                                          child: Center(
                                              child: Text(
                                                  'SIGN UP',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Poppins-Bold',
                                                      fontSize: 18.0,
                                                      letterSpacing: 1.0
                                                  )
                                              )
                                          )
                                      )
                                  )
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(40),
                        ),
                      ],
                    )
                )
            ),
          ],
        )
    );
  }
}