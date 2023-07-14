import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_clean_architecture_tdd/core/error/failure.dart';
import 'package:number_trivia_clean_architecture_tdd/core/utils/input_converter.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia_clean_architecture_tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

@GenerateNiceMocks([
  MockSpec<GetConcreteNumberTrivia>(),
  MockSpec<GetRandomNumberTrivia>(),
  MockSpec<InputConverter>(),
])
import 'number_trivia_bloc_test.mocks.dart';

void main() {
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;
  late NumberTriviaBloc numberTriviaBloc;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    numberTriviaBloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('initial state of the bloc should be NumberTriviaInitial', () {
    expect(numberTriviaBloc.state, equals(NumberTriviaInitial()));
  });

  group(
    "getConcreteNumberTrivia",
    () {
      const tInputIntString = '5';
      const parsedInt = 5;
      const tNumberTrivia = NumberTrivia(text: 'test', number: 5);
      const concreteParams = ConcreteNumberParams(parsedInt);

      setUpInputConverterSuccessAndConcreteTriviaUseCaseSuccess() {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Right(parsedInt));
        when(mockGetConcreteNumberTrivia(concreteParams)).thenAnswer(
          (_) async => const Right(tNumberTrivia),
        );
      }

      setUpInputConverterValidationFailed() {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Left(InvalidInputFailure('Invalid input value')));
      }

      setUpInputConverterSuccessAndConcreteTriviaUseCaseError() {
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(const Right(parsedInt));
        when(mockGetConcreteNumberTrivia(concreteParams)).thenAnswer(
          (_) async => const Left(ServerFailure('Something went wrong')),
        );
      }

      test(
        'should call InputConverter to validate input string when add Get Trivia event',
        () async {
          // arrange
          setUpInputConverterSuccessAndConcreteTriviaUseCaseSuccess();
          // act
          numberTriviaBloc.add(
            const GetTriviaForConcreteNumber(tInputIntString),
          );
          await untilCalled(
            mockInputConverter.stringToUnsignedInteger(tInputIntString),
          );
          // assert
          verify(mockInputConverter.stringToUnsignedInteger(tInputIntString));
        },
      );

      blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should call GetConcreteNumberTrivia when add GetTriviaForConcreteNumber and the InputConverter validate success',
        setUp: () =>
            setUpInputConverterSuccessAndConcreteTriviaUseCaseSuccess(),
        build: () => numberTriviaBloc,
        act: (bloc) => bloc.add(
          const GetTriviaForConcreteNumber(tInputIntString),
        ),
        verify: (_) {
          verify(mockGetConcreteNumberTrivia(concreteParams)).called(1);
        },
      );
      blocTest<NumberTriviaBloc, NumberTriviaState>(
        '''emits [NumberTriviaLoading, NumberTriviaLoadingSuccess] when GetTriviaForConcreteNumber is added
        and the InputConverter validation success and the usecase return the trivia successfully.''',
        build: () => numberTriviaBloc,
        setUp: () =>
            setUpInputConverterSuccessAndConcreteTriviaUseCaseSuccess(),
        act: (bloc) => bloc.add(
          const GetTriviaForConcreteNumber(tInputIntString),
        ),
        expect: () => successStatesOrder,
      );
      blocTest<NumberTriviaBloc, NumberTriviaState>(
        '''emits [NumberTriviaLoading, NumberTriviaLoadingFailure] when GetTriviaForConcreteNumber is added
        and the InputConverter validation Failed''',
        build: () => numberTriviaBloc,
        setUp: () => setUpInputConverterValidationFailed(),
        act: (bloc) => bloc.add(
          const GetTriviaForConcreteNumber(tInputIntString),
        ),
        expect: () => errorStatesOrder,
      );
      blocTest<NumberTriviaBloc, NumberTriviaState>(
        '''emits [NumberTriviaLoading, NumberTriviaLoadingFailure] when GetTriviaForConcreteNumber is added
        and the InputConverter validation Success and the usecase return Failure''',
        build: () => numberTriviaBloc,
        setUp: () => setUpInputConverterSuccessAndConcreteTriviaUseCaseError(),
        act: (bloc) => bloc.add(
          const GetTriviaForConcreteNumber(tInputIntString),
        ),
        expect: () => errorStatesOrder,
      );
    },
  );
  group(
    "getRandomNumberTrivia",
    () {
      const tNumberTrivia = NumberTrivia(text: 'test', number: 5);

      setUpGetRandomTriviaUseCaseSuccess() {
        when(mockGetRandomNumberTrivia(null)).thenAnswer(
          (_) async => const Right(tNumberTrivia),
        );
      }

      setUpGetRandomTriviaUseCaseError() {
        when(mockGetRandomNumberTrivia(null)).thenAnswer(
          (_) async => const Left(ServerFailure('Something went wrong')),
        );
      }

      blocTest<NumberTriviaBloc, NumberTriviaState>(
        'should call GetRandomNumberTrivia when add Get Random Trivia event',
        setUp: () => setUpGetRandomTriviaUseCaseSuccess(),
        build: () => numberTriviaBloc,
        act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
        verify: (_) => verify(mockGetRandomNumberTrivia(null)).called(1),
      );
      blocTest<NumberTriviaBloc, NumberTriviaState>(
        '''emits [NumberTriviaLoading, NumberTriviaLoadingSuccess] when GetTriviaForRandomNumber is added
        and the usecase return the trivia successfully.''',
        build: () => numberTriviaBloc,
        setUp: () => setUpGetRandomTriviaUseCaseSuccess(),
        act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
        expect: () => successStatesOrder,
      );

      blocTest<NumberTriviaBloc, NumberTriviaState>(
        '''emits [NumberTriviaLoading, NumberTriviaLoadingFailure] when GetTriviaForRandomNumber is added
        and the usecase return Failure''',
        build: () => numberTriviaBloc,
        setUp: () => setUpGetRandomTriviaUseCaseError(),
        act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
        expect: () => errorStatesOrder,
      );
    },
  );
}

List<TypeMatcher<NumberTriviaState>> get successStatesOrder => [
      isA<NumberTriviaLoading>(),
      isA<NumberTriviaLoadingSuccess>(),
    ];

List<TypeMatcher<NumberTriviaState>> get errorStatesOrder {
  return [
    isA<NumberTriviaLoading>(),
    isA<NumberTriviaLoadingError>(),
  ];
}
