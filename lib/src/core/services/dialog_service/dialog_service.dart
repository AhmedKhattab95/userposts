import 'package:flutter/material.dart';
import 'package:topics/src/core/delegates.dart';

import '../service_lib.dart';

abstract class DialogService {
  BuildContext get context => NavigationService.context;

  Future<T?> showAndroidDialog<T>(
      {required Widget acceptWidget,
      required ResultCallBack<T?> acceptCallBack,
      required Widget cancelWidget,
      required ResultCallBack<T?> cancelCallBack,
      Widget? title,
      Widget? body,
      });

  Future<T?> showIOSDialog<T>(
      {required Widget acceptWidget,
      required ResultCallBack<T?> acceptCallBack,
      required Widget cancelWidget,
      required ResultCallBack<T?> cancelCallBack,
      Widget? title,
      Widget? body});

  Future<T?> showInfoDialog<T>(
      {required Widget body,
      required Widget actionButton,
      required ResultCallBack<T?> callback,
      Widget? title,
      Widget? bodyWidget,
      bool dismissible = false});

  /// when want to return output should call Navigator.pop(context, result);
  Future<T?> showCustomDialog<T>(
      {required Widget bodyWidget,
      WillPopCallback? willPopCallback,
      Color backgroundColor = Colors.white,
      BorderRadius radius = BorderRadius.zero,
      bool dismissible = false,
      EdgeInsets padding = const EdgeInsets.all(16),
      EdgeInsets margin = const EdgeInsets.all(20)});
}
