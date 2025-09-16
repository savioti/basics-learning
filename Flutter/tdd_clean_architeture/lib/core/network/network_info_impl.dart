import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:study_flutter_clean_architeture/core/network/network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImpl({required this.internetConnectionChecker});

  @override
  Future<bool> get isConnected async {
    return internetConnectionChecker.hasConnection;
  }
}
