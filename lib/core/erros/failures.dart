import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

//extensão da abstração
class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}
