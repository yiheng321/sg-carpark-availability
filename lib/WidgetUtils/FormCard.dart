import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sg_carpark_availability/Controller/Validation.dart';

String? username, password;
GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController userNameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmpasswordController = TextEditingController();

class FormCard extends StatelessWidget {
  static const Map<String, String> Pages = {
    'login': "Login",
    'signup': "Sign Up"
  };

  late String PageName;
  late double Height;

  FormCard(String page) {

    PageName = Pages[page]!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: ScreenUtil()
            .setHeight((PageName == 'Login') ? 470 : 570),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0),
              blurRadius: 15.0,
            ),
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, -10.0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(PageName,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(45),
                      fontFamily: 'Poppins-Bold',
                      letterSpacing: .6,
                    )),
                TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    labelText: 'UserName',
                    icon: Icon(Icons.person),
                    suffixIcon: (true)
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              userNameController.clear();
                            },
                          )
                        : null,
                  ),
                  keyboardType: TextInputType.text,
                  validator: Validation().validateUserName,
                  onSaved: (String ? value) {
                    username = value;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'PassWord',
                    icon: Icon(Icons.lock),
                    suffixIcon: (true)
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              passwordController.clear();
                            },
                          )
                        : null,
                  ),
                  obscureText: true,
                  validator: Validation().validatePassWord,
                  onSaved: (String ? value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                )
              ],
            ),
          ),
        ));
  }
}
