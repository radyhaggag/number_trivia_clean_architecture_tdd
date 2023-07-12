import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_architecture_tdd/core/api/api_consumer.dart';

@GenerateNiceMocks([
  MockSpec<Dio>(),
])
import 'api_consumer_test.mocks.dart';

void main() {
  late MockDio dio;
  late DioConsumer dioConsumer;

  setUp(() {
    dio = MockDio();
    dioConsumer = DioConsumer(dio);
  });

  group('dio consumer methods', () {
    test('should call dio.get method when call dioConsumer.get', () async {
      when(dio.get('endpoint')).thenAnswer(
        (_) async => Response(requestOptions: RequestOptions()),
      );
      // act
      await dioConsumer.get(endpoint: 'endpoint');
      // assert
      verify(dio.get('endpoint'));
    });
  });
}
