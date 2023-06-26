import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_architecture_tdd/core/error/exceptions.dart';
import 'package:number_trivia_clean_architecture_tdd/core/error/failure.dart';
import 'package:number_trivia_clean_architecture_tdd/core/network/network_info.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';

@GenerateNiceMocks([
  MockSpec<NumberTriviaRemoteDataSource>(),
  MockSpec<NumberTriviaLocalDataSource>(),
  MockSpec<NetworkInfo>()
])
import 'number_trivia_repository_impl_test.mocks.dart';

void main() {
  late NumberTriviaRepositoryImpl numberTriviaRepositoryImpl;
  late MockNumberTriviaRemoteDataSource mockNumberTriviaRemoteDataSource;
  late MockNumberTriviaLocalDataSource mockNumberTriviaLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockNumberTriviaRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mockNumberTriviaLocalDataSource = MockNumberTriviaLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    numberTriviaRepositoryImpl = NumberTriviaRepositoryImpl(
      numberTriviaRemoteDataSource: mockNumberTriviaRemoteDataSource,
      numberTriviaLocalDataSource: mockNumberTriviaLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    const tNumberModel = NumberTriviaModel(text: 'test', number: tNumber);
    const NumberTrivia tNumberEntity = tNumberModel;
    test('should check if the device connected to internet', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          'should return remote data when the call for remote data source success',
          () async {
        // arrange
        when(mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenAnswer((_) async => tNumberModel);
        // act
        final result = await numberTriviaRepositoryImpl.getConcreteNumberTrivia(
          tNumber,
        );
        // assert
        verify(
          mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber),
        );
        expect(result, equals(const Right(tNumberEntity)));
      });

      test('should cache data when the call for remote data source success',
          () async {
        // arrange
        when(mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenAnswer((_) async => tNumberModel);
        // act
        await numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        // assert
        verify(
          mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber),
        );
        verify(
          mockNumberTriviaLocalDataSource.cacheNumberTrivia(tNumberModel),
        );
      });

      test(
          'should return server failure when the call for remote data source unsuccess',
          () async {
        // arrange
        when(mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber))
            .thenThrow(ServerException());
        // act
        final result =
            await numberTriviaRepositoryImpl.getConcreteNumberTrivia(tNumber);
        // assert
        verify(
          mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber),
        );
        verifyZeroInteractions(mockNumberTriviaLocalDataSource);
        expect(result, equals(const Left(ServerFailure(''))));
      });
    });
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
    });
  });
}
