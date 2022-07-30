import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<dynamic>? properties;
  String message;
  String? title;

  Failure({this.title, required this.message, this.properties = const <dynamic>[]});

  @override
  List<Object?> get props => [message, properties];
}

class GenericFailure extends Failure {
  GenericFailure({String? message,List<dynamic>? properties}) : super(message: message??"something went worng", properties: properties);
}

class APIFailure extends Failure {
  APIFailure({required String message, List<dynamic>? properties}) : super(message: message, properties: properties);
}
