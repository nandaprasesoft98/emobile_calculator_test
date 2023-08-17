import 'package:emobile_calculator_test/misc/calculator_core.dart';
import 'package:emobile_calculator_test/misc/load_data_result.dart';

class CalculateFromExpressionUseCase {
  final CalculatorCore calculatorCore;

  CalculateFromExpressionUseCase({
    required this.calculatorCore
  });

  LoadDataResult<num> execute(String expression) {
    return calculatorCore.execute(expression);
  }
}