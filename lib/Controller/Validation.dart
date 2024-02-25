import 'package:sg_carpark_availability/WidgetUtils/FormCard.dart';
import 'package:sg_carpark_availability/WidgetUtils/FormCardSignUp.dart' as su;
import 'package:sg_carpark_availability/Controller//Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class validBase {
  Future<bool> Signin();
  Future<bool> Signup();
  bool validateSignin();
  bool validateUser(String email, String password);
  Map<String, String> GetStatus(String mode, bool status);
  String validateUserName(String value);
  String validatePassWord(String value);
  String validateConfirmPassWord(String value);
}

bool _validationstate = false;

class Validation {
  late String status;
  late User user;

  Future<void> Signin() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await Auth().signInWithEmailAndPassword(username!, password!);
      validateUser(username!, password!);
    } else {
      print('Sign in validation fail');
    }
  }

  Future<void> Signup() async {
    if (su.formKey.currentState!.validate()) {
      su.formKey.currentState!.save();

      await Auth().createUserWithEmailAndPassword(su.username!, su.password!);
      validateUser(username!, password!);
    } else {
      print('Sign up validation fail');
    }
  }

  bool validateSignin() {
    return (_validationstate && (user != null )? true : false);
  }
  bool validateSignup() {
    return (_validationstate ? true : false);
  }

  Future<void> validateUser(String email, String password) async {
    Auth().authStateChanges().listen((User user) {
      try {
        print( "authStateChanges");
            } catch (e) {
        print( "authStateChanges ERROR");
        print(e);
        ;
      }
    } as void Function(User? event)?);
  }

  Map<String, String> GetStatus(String mode, bool status) {
    Map<String, String> StatusList = {'mode': '', 'title': '', 'body': ''};
    print("GetStatus status is : ");
    print(status);
    StatusList['mode'] = mode;
    if (status == true) {
      StatusList['title'] = '$mode to sg_carpark_availability!';
      StatusList['body'] = 'You have successfully $mode , \n Enjoy!';
    } else {
      StatusList['title'] = 'Sorry';
      StatusList['body'] = '$mode unsuccessful, Try again !';
    }
    return StatusList;
  }

  String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      _validationstate = false;
      return 'username can not be empty';
    } else if (value.length < 4) {
      _validationstate = false;
      return 'username < 4 digits';
    } else {
      _validationstate = true;
    }
    return null;
  }

  String? validatePassWord(String ? value) {
    if (value == null || value.isEmpty) {
      _validationstate = false;
      return 'password can not be none';
    } else if (value.trim().length < 4) {
      _validationstate = false;
      return 'password < 4 digits';
    } else {
      _validationstate = true;
    }
    return null;
  }

  String? validateConfirmPassWord(String ? value) {
    if (value == null ||value.isEmpty) {
      _validationstate = false;
      return 'password can not be none';
    } else if (value.trim().length < 4) {
      _validationstate = false;
      return 'password < 4 digits';
    } else if (value != su.passwordController.text) {
      _validationstate = false;
      return 'password not the same';
    } else {
      _validationstate = true;
    }
    return null;
  }
}
