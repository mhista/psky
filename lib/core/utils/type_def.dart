

import 'package:fpdart/fpdart.dart';

typedef ResultFuture<T> = Future<Either<String, T>>;
typedef ResultVoid = Future<Either<String, void>>;
