import 'package:flutter/material.dart';

bool isShowing = false;

class LoaderService {
  bool hideLoading(BuildContext context) {
    if (context == null) {
      return true;
    }
    isShowing = false;
    Navigator.of(context).pop(true);
    return true;
  }

  bool showLoading(BuildContext context) {
    if (context == null) {
      return true;
    }
    isShowing = true;
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        },
        useRootNavigator: false);
    return true;
  }
  bool checkLoading(){
    return isShowing;
  }
}