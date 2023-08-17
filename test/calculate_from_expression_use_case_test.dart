import 'package:emobile_calculator_test/domain/usecase/calculate_from_expression_use_case.dart';
import 'package:emobile_calculator_test/misc/calculator_core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Calculate From Expression Use Case', () {
    late CalculateFromExpressionUseCase calculateFromExpressionUseCase;

    setUp(() {
      calculateFromExpressionUseCase = CalculateFromExpressionUseCase(
        calculatorCore: CalculatorCore()
      );
    });

    test('Arithmetic Operations', () {
      expect(calculateFromExpressionUseCase.execute('3 + 4 * 2 / (1 - 5) ^ 2'), equals(3.5));
    });

    test('Function Evaluations', () {
      expect(calculateFromExpressionUseCase.execute('sin(45) + cos(30)'), closeTo(1.00515497442, 0.00001));
    });

    test('Operator Precedence', () {
      expect(calculateFromExpressionUseCase.execute('2 + 3 * 4 ^ 2 / 2'), equals(26.0));
    });

    test('Nested Functions', () {
      expect(calculateFromExpressionUseCase.execute('sin(cos(30))'), closeTo(0.15364047996, 0.00001));
    });

    test('Negative Numbers', () {
      expect(calculateFromExpressionUseCase.execute('-2 + 5 * -3'), equals(-17.0));
    });

    test('Decimal Numbers', () {
      expect(calculateFromExpressionUseCase.execute('0.5 + 1.5 * 2'), equals(3.5));
    });

    test('Complex Expression', () {
      expect(calculateFromExpressionUseCase.execute('(1 + 2) * 3 - 4 ^ 2 / (5 + 1)'), closeTo(6.33333333333, 0.00001));
    });
  });
}