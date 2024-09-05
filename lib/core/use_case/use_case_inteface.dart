import 'package:fpdart/fpdart.dart';

import '../error/failure.dart';

abstract interface class UseCaseInterface<successTyp,Params > {
  Future<Either<Failure, successTyp>> call(Params params);
}
class NoParams{}