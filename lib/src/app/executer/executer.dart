import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:topics/src/app/widgets/widgets_lib.dart';
import 'package:topics/src/localization/app_localization.dart';

import '../../core/core_lib.dart';
import 'failures.dart';
import 'package:dartz/dartz.dart';

/// public action method to handle action and make handle of error centralized through all app
/// should implement custom exceptions and be used in app side
/// depends on   dartz: ^0.10.0

// custom handlation and if return true then no need to handle case
typedef HndelErrorCallBack = Future<bool> Function({Failure? failure, Exception? exception});
typedef EitherResultCallBack<T> = Future<Either<Failure, T>> Function();

/// execute specific function  and if success will return right side T(result)
/// and if there are any error/exception will return left side Failure object
class ExecuterImpl extends Executer {
  final ConnectivityService connectivityService;
  final DialogService dialogService;
  final NavigationService navigationService;

  ExecuterImpl({required this.connectivityService, required this.dialogService, required this.navigationService});

  @override
  Future<Either<Failure, T>> execute<T>(EitherResultCallBack<T> action,
      {bool checkInternet = true, HndelErrorCallBack? handleError}) async {
    try {
      if (checkInternet == true) {
        await _checkInternetConnection();
      }
      var result = await action.call();
      if (result is Left) {
        _handleFailures((result as Left).value);
      }
      return result;
    } on DioError catch (error, st) {
      // log.error(error.toString(), data:// logData(stackTrace: st));
      String message = '${AppLocalization.translation.genericError}dio erroor$error';
      var handled = await handleError?.call(failure: GenericFailure(message: error.toString()));
      if (handled != true) {
        _handleGenericError(AppLocalization.translation.genericError);
      } else if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.sendTimeout ||
          error.type == DioErrorType.connectTimeout) {
        message = AppLocalization.translation.requestTimeoutErrorMessage;
        _handleTimeOut(message);
      } else if (error.error == DioErrorType.cancel) {
        message = AppLocalization.translation.requestHasCancelledErrorMessage;
        _handleRequestCancelled(message);
      } else if (error.response?.statusCode != null &&
          error.response!.statusCode! >= 500 &&
          error.response!.statusCode! <= 600) {
        message = AppLocalization.translation.genericError;
        _handleGenericError(message);
      } else if (error.response?.statusCode != null &&
          (error.response!.statusCode! == 204 || error.response!.statusCode! == 404)) {
        message = AppLocalization.translation.noContent;
        _handleGenericError(message);
      } else if (error.response?.statusCode != null && error.response!.statusCode == 401) {
        message = AppLocalization.translation.unAuthorizedError;
        _handleGenericError(message);
      } else {
        _handleGenericError(message);
      }
      _logError(error, st, 'API-ERROR: ${error.toString()}');

      return Left(APIFailure(message: message));
    } catch (ex, st) {
      // log.error(ex.toString(), data: LogData(stackTrace: st));
      // handle user action
      var handled = await handleError?.call(failure: GenericFailure(message: ex.toString()));
      if (handled != true) {
        _handleGenericError(AppLocalization.translation.genericError);
      }
      _logError(ex, st, ex.toString());

      return Left(GenericFailure());
      //todo: add cases for custom exceptions here
    } finally {}
  }

  Future<bool> _checkInternetConnection({VoidCallback? callBack}) async {
    var connected = await connectivityService.hasInterentConnection;
    if (!connected) {
      await navigationService.push(NoConnectionView(afterNetworkBackCallback: callBack));
    }
    return connected;
  }

  Future<void> _handleFailures(Failure failure) async {
    await dialogService.showCustomDialog(bodyWidget: Text(failure.message),dismissible: true);

    //todo if there is specific failure type need to check on it will check on his type then handle it with custom handelation
  }

  void _handleRequestCancelled(String message) => _handleError(message);

  void _handleGenericError(String message) => _handleError(message);

  void _handleTimeOut(String message) => print('request time out');

  Future<void> _handleError(String message) async {
    await dialogService.showCustomDialog(bodyWidget: Text(message),dismissible: true);
  }

  void _logError(dynamic error, StackTrace st, dynamic reason) {
    try {
      if (kDebugMode) {
        print(error.toString());
      }
    } catch (ex) {
      //should not do any code here
    }
  }
}

abstract class Executer {
  /// centralize place to run specific function and  catch exception and handle it centralized on all application
  Future<Either<Failure, T>> execute<T>(EitherResultCallBack<T> action,
      {bool checkInternet = true, HndelErrorCallBack? handleError});
}
