import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:number_trivia_clean_architecture_tdd/core/api/api_consumer.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';

@GenerateNiceMocks([MockSpec<DioConsumer>()])
import 'number_trivia_remote_data_source_test.mocks.dart';

void main() {
  late MockDioConsumer apiConsumer;
  late NumberTriviaRemoteDataSourceImpl dataSource;

  setUp(
    () {
      apiConsumer = MockDioConsumer();
      dataSource = NumberTriviaRemoteDataSourceImpl(apiConsumer);
    },
  );

  group('getLastNumberTriv', () {});
}
