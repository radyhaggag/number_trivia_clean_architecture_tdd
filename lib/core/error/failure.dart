import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class SocketFailure extends Failure {
  const SocketFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
