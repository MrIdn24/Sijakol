import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sijakol/helper/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum BasicState {
  loading, none, success, error, info
}

class BasicAlert {

  static BuildContext? context;

  bool isOutputSucces = false;

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
    return (BuildContext context, Widget? child) {
      BasicAlert.context = context;
      return EasyLoading.init()(context, child);
    };
  }

  Future<void> showBasicAlert(BasicState state, String? message) async {
    switch(state) {
      case BasicState.loading:
        isOutputSucces = true;
        EasyLoading.show(status: "Loading...");
      case BasicState.success:
        isOutputSucces = true;
        EasyLoading.showSuccess(message ?? "");
      case BasicState.error:
        isOutputSucces = true;
        EasyLoading.showError(message ?? "");
      case BasicState.info :
        isOutputSucces = true;
        EasyLoading.showInfo(message ?? "");
      case BasicState.none:
        isOutputSucces = true;
        EasyLoading.dismiss();
    }


    if (!isOutputSucces){
      await Future.delayed(const Duration(seconds: 60), () {
        EasyLoading.showError("Waktu eksekusi maksimum terlampaui 60 detik");
      });
      if (context != null && Navigator.canPop(context!)) {
        Navigator.of(context!).pop();
      }
    }
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  final Function(BuildContext) onInitContext;

  MyNavigatorObserver(this.onInitContext);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    onInitContext(navigator!.context);
  }
}