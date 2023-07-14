import 'package:dartz/dartz.dart';
import 'package:number_trivia_clean_architecture_tdd/core/error/failure.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String stringNumber) {
    try {
      final integer = int.parse(stringNumber);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return const Left(InvalidInputFailure('Invalid input value'));
    }
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(super.message);
}
