import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_architecture_tdd/core/api/api_consumer.dart';
import 'package:number_trivia_clean_architecture_tdd/core/error/exceptions.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture.dart';
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

  void setUpDioClientWithStatusCode200(String endpoint) {
    when(apiConsumer.get(endpoint: endpoint)).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
          headers: {'Content-Type': 'application/json'},
        ),
        statusCode: 200,
        data: json.decode(fixture('trivia.json')),
      ),
    );
  }

  void setUpDioClientWithStatusCode404(String endpoint) {
    when(apiConsumer.get(endpoint: endpoint)).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(
          headers: {'Content-Type': 'application/json'},
        ),
        statusCode: 400,
        data: 'Something went wrong',
      ),
    );
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 42;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      json.decode(fixture('trivia.json')),
    );

    test('should preform a get request on a url with number being the endpoint',
        () async {
      // arrange
      setUpDioClientWithStatusCode200('$tNumber');
      // act
      dataSource.getConcreteNumberTrivia(tNumber);
      // assert
      verify(apiConsumer.get(endpoint: '$tNumber'));
    });

    test('should return number trivia when the status code is 200', () async {
      // arrange
      setUpDioClientWithStatusCode200('$tNumber');
      // act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);
      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw an exception when the status code is 404 or other',
        () async {
      // arrange
      setUpDioClientWithStatusCode404('$tNumber');
      // act
      final call = dataSource.getConcreteNumberTrivia;
      // assert
      expect(
        () => call(tNumber),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
  });
  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(
      json.decode(fixture('trivia.json')),
    );

    test('should preform a get request on a url with number being the endpoint',
        () async {
      // arrange
      setUpDioClientWithStatusCode200('random');
      // act
      dataSource.getRandomNumberTrivia();
      // assert
      verify(apiConsumer.get(endpoint: 'random'));
    });

    test('should return number trivia when the status code is 200', () async {
      // arrange
      setUpDioClientWithStatusCode200('random');
      // act
      final result = await dataSource.getRandomNumberTrivia();
      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw an exception when the status code is 404 or other',
        () async {
      // arrange
      setUpDioClientWithStatusCode404('random');
      // act
      final call = dataSource.getRandomNumberTrivia;
      // assert
      expect(
        () => call(),
        throwsA(const TypeMatcher<ServerException>()),
      );
    });
  });
}
