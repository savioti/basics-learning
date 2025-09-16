abstract class Failure {
  final Object error;

  const Failure({required this.error});
}

class ServerFailure extends Failure {
  ServerFailure({required super.error});
}

class ConversionFailure extends Failure {
  ConversionFailure({required super.error});
}
