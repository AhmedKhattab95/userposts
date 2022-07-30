
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../delegates.dart';
import 'dialog_service.dart';

class DialogServiceImpl extends DialogService {

  @override
  Future<T?> showAndroidDialog<T>(
      {required Widget acceptWidget,
      required ResultCallBack<T?> acceptCallBack,
      required Widget cancelWidget,
      required ResultCallBack<T?> cancelCallBack,
      Widget? title,
      Widget? body}) async {
    var result = await _showDialog<T>(
        AlertDialog(
          title: title,
          content: body,
          actions: <Widget>[
            TextButton(onPressed: () => _dimissDialog(context, acceptCallBack), child: acceptWidget),
            TextButton(onPressed: () => _dimissDialog(context, cancelCallBack), child: cancelWidget),
          ],
        ),
        dismissible: false);
    return result;
  }

  @override
  Future<T?> showIOSDialog<T>(
      {required Widget acceptWidget,
      required Widget cancelWidget,
      required ResultCallBack<T?> acceptCallBack,
      required ResultCallBack<T?> cancelCallBack,
      Widget? title,
      Widget? body}) async {
    var result = await _showDialog<T>(
        CupertinoAlertDialog(
          title: title,
          content: body,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: acceptWidget,
              onPressed: () => _dimissDialog(context, acceptCallBack),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: cancelWidget,
              onPressed: () => _dimissDialog(context, cancelCallBack),
            )
          ],
        ),
        dismissible: false);
    return result;
  }

  @override
  Future<T?> showCustomDialog<T>(
      {required Widget bodyWidget,
      WillPopCallback? willPopCallback,
      Color backgroundColor = Colors.white,
      BorderRadius radius = BorderRadius.zero,
      bool dismissible = false,
      EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
      EdgeInsets margin = const EdgeInsets.all(15)}) async {
    return _showDialog<T>(
        WillPopScope(
          onWillPop: willPopCallback ?? () => Future.value(dismissible),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: padding,
                  margin: margin,
                  decoration: BoxDecoration(color: backgroundColor, borderRadius: radius),
                  child: Dialog(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    insetPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: radius,
                    ),
                    child: bodyWidget,
                  )),
            ],
          ),
        ),
        dismissible: dismissible);
  }

  @override
  Future<T?> showInfoDialog<T>(
      {required Widget body,
      required Widget actionButton,
      required ResultCallBack<T?> callback,
      Widget? title,
      Widget? bodyWidget,
      bool dismissible = false}) async {
    var result = await _showDialog<T>(
        AlertDialog(
          title: title,
          content: body,
          actions: <Widget>[
            TextButton(onPressed: () => _dimissDialog(context, callback), child: actionButton),
          ],
        ),
        dismissible: dismissible);

    return result;
  }

  Future<T?> _showDialog<T>(Widget dialog, {bool dismissible = false}) async {
    return showDialog<T>(
        context: context,
        barrierDismissible: dismissible,
        builder: (_) {
          return WillPopScope(onWillPop: () => Future.value(dismissible), child: dialog);
        });
  }

  Future<void> _dimissDialog(BuildContext context, ResultCallBack callback) async {
    var result = await callback.call();
    Navigator.pop(context, result);
  }
}
