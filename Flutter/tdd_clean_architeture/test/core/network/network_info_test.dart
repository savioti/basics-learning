import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:study_flutter_clean_architeture/core/network/network_info_impl.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late final MockInternetConnectionChecker internetConnectionChecker;
  late final NetworkInfoImpl networkInfo;

  setUpAll(() {
    internetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(
      internetConnectionChecker: internetConnectionChecker,
    );

    when(internetConnectionChecker.hasConnection).thenAnswer((_) async => true);
  });

  group('isConnected', () {
    test('should forward the call to DataConnectionChecker.hasConnection',
        () async {
      when(internetConnectionChecker.hasConnection)
          .thenAnswer((_) async => true);

      final result = await networkInfo.isConnected;

      verify(internetConnectionChecker.hasConnection);
      expect(result, true);
    });
  });
}
