import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../erros/failures.dart';

//clase abstrata para usecase do domain
abstract class UseCase<Output, Input> {
  //utilizando package dartz para tratar erros => Either<error, sucess>
  Future<Either<Failure, Output>> call(Input input);
}

//quando Input não possui parâmetros
@override
class NoParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}
