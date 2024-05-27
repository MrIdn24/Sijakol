import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sijakol/helper/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

enum BasicState {
  loading, none, success, error, info
}

class BasicAlert {

  BasicAlert();

  static TransitionBuilder init() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2500)
      ..indicatorType = EasyLoadingIndicatorType.fadingFour
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 16.0
      ..backgroundColor = ColorPrimary
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..textStyle = const TextStyle(fontSize: 18, fontStyle: FontStyle.normal, color: Colors.white)
      ..maskColor = Colors.black.withOpacity(0.5)
      ..userInteractions = false
      ..maskType = EasyLoadingMaskType.custom;
    return EasyLoading.init();
  }

  Future<void> showBasicAlert(BasicState state, String? message) async {
    switch(state) {
      case BasicState.loading:
        EasyLoading.show(status: "Loading...");
      case BasicState.success:
        EasyLoading.showSuccess(message ?? "");
      case BasicState.error:
        EasyLoading.showError(message ?? "");
      case BasicState.info :
        EasyLoading.showInfo(message ?? "");
      case BasicState.none:
        EasyLoading.dismiss();
    }

    return Future.delayed(const Duration(milliseconds: 2600), () => ());
  }
}