import 'package:flutter_fundamental_3/data/api_service/api_service_test.dart';
import 'package:flutter_fundamental_3/data/model/restaurant.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'api_service_test.mocks.dart';


@GenerateMocks([http.Client])
void main() {
  group('Fetch List Restaurant', () {
    test('returns an Restaurant if the http call completes successfully', () async {
      final client = MockClient();

      when(client.get(Uri.parse(ApiServiceTest.baseUrl + ApiServiceTest.list)))
          .thenAnswer((_) async => http.Response(
          '{"restaurants":[]}',
          200
      ));
      expect(await ApiServiceTest(client: client).listRestaurant(), isA<RestaurantResult>());
    });
  });
}

