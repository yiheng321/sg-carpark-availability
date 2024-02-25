import 'package:flutter/material.dart';
import 'package:sg_carpark_availability/Controller/Validation.dart';

class Popwindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // print (list);

  Widget Popupwindow(BuildContext context, String mode, bool status) {
    var list = Validation().GetStatus(mode, status);
    print('var list = Validation().GetStatus(mode, status);');
    print(status);
    // var list = {'mode': 'Login', 'title': 'Sorry', 'body': 'Login unsuccessful, Try again !'};

    return AlertDialog(
      title: Text(list['title']!),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(list['body']!),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            (list['mode'] == 'login' && status == true)
                ? Navigator.of(context).pop()
                : (list['mode'] == 'sign up' && status == true)
                    ? Navigator.of(context).pop()
                    : null;
            Navigator.of(context).pop();
            print(status);
            print("list['mode'] is :");
            print(list['mode']);
            (status == true) ? print("TRUE") : print("FALSE");
          },
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).primaryColor, // Text color
          ),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
